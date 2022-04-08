import 'dart:convert';
import 'dart:isolate';
import 'package:waultar/core/ai/image_classifier_mobilenetv3.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/startup.dart';

Future imageClassifierWorkerBody(dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is IsolateImageClassifyStartPackage) {
    try {
      await setupIsolate(mainSendPort, data, data.waultarPath);
      var performance = locator.get<PerformanceHelper>(instanceName: 'performance');
      var mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
      if (data.isPerformanceTracking) {
        performance.init(newParentKey: "Classifier");
        performance.startReading(performance.parentKey);
      }
      if (data.isPerformanceTracking) {
        performance.startReading("Setup of classifier");
      }
      var classifier = ImageClassifierMobileNetV3();
      if (data.isPerformanceTracking) {
        var key = "Setup of classifier";
        performance.addReading(performance.parentKey, key, performance.stopReading(key));
      }

      int step = 1;
      int offset = 0;
      int limit = step;
      if (data.isPerformanceTracking) {
        performance.startReading("Loading of images");
      }
      var images = mediaRepo.getImagesPagination(offset, limit);
      if (data.isPerformanceTracking) {
        var key = "Loading of images";
        performance.addReading(performance.parentKey, key, performance.stopReading(key));
      }

      while (images.isNotEmpty && (data.limit == null || offset < data.limit!)) {
        for (var image in images) {
          if (data.isPerformanceTracking) {
            performance.startReading("Classify Image");
          }
          var mediaTags = classifier.predict(image.uri, 5);
          if (data.isPerformanceTracking) {
            var key = "Classify Image";
            performance.addReading(performance.parentKey, key, performance.stopReading(key));
          }

          if (mediaTags.isEmpty) {
            image.mediaTagScores = ["NULL"];
            image.mediaTags = "NULL";
          } else {
            image.mediaTagScores = mediaTags.map((e) => ",(${e.item1},${e.item2})").toList();

            image.mediaTags =
                mediaTags.fold<String>("", (previous, next) => previous += ",${next.item1}");
          }
        }

        mediaRepo.updateImages(images);
        mainSendPort.send(MainImageClassifyProgressPackage(amountTagged: step, isDone: false));
        offset += step;

        if (data.isPerformanceTracking) {
          performance.startReading("Loading of images");
        }
        images = mediaRepo.getImagesPagination(offset, limit);
        if (data.isPerformanceTracking) {
          var key = "Loading of images";
          performance.addReading(performance.parentKey, key, performance.stopReading(key));
        }
      }

      if (data.isPerformanceTracking) {
        performance.addData(performance.parentKey,
            duration: performance.stopReading(performance.parentKey));
      }

      mainSendPort.send(MainImageClassifyProgressPackage(
        amountTagged: step,
        isDone: true,
        performanceDataPoint: data.isPerformanceTracking ? jsonEncode(performance.parentDataPoint.toMap()) : "",
      ));

      if (data.isPerformanceTracking) {
        performance.dispose();
      }
    } catch (e, stacktrace) {
      mainSendPort.send(LogRecordPackage(e.toString(), stacktrace.toString()));
    } finally {
      var _context = locator.get<ObjectBox>(instanceName: 'context');
      _context.store.close();
    }
  }
}

// run setupServices with configuration
// this call enables you to use all normal dependencies, the logger and objectbox
// - it abstracts away that the code being executed is in its own memory space
Future<void> setupIsolate(SendPort sendPort, InitiatorPackage setupData, String waultarPath) async {
  await setupServices(
      testing: setupData.testing, isolate: true, sendPort: sendPort, waultarPath: waultarPath);
}

class IsolateImageClassifyStartPackage extends InitiatorPackage {
  String waultarPath;
  int? limit;
  bool isPerformanceTracking;

  IsolateImageClassifyStartPackage({
    required this.waultarPath,
    this.limit,
    required this.isPerformanceTracking,
  });
}

class MainImageClassifyProgressPackage {
  int amountTagged;
  bool isDone;
  String? performanceDataPoint;

  MainImageClassifyProgressPackage({
    required this.amountTagged,
    required this.isDone,
    this.performanceDataPoint,
  });
}
