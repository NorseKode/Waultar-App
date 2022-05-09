import 'dart:convert';
import 'dart:isolate';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/image_model_enum.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/ai/image_classifier_efficient_net_b4.dart';
import 'package:waultar/core/ai/image_classifier_mobilenetv3.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/startup.dart';

Future imageClassifierWorkerBody(dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is IsolateImageClassifyStartPackage) {
    try {
      await setupIsolate(mainSendPort, data, data.waultarPath);
      var logger = locator.get<BaseLogger>(instanceName: 'logger');
      var performance = PerformanceHelper(
          pathToPerformanceFile: locator.get<String>(instanceName: 'performance_folder'));
      var mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
      if (data.isPerformanceTracking) {
        performance.init(newParentKey: "Classifier");
        performance.startReading(performance.parentKey);
      }
      if (data.isPerformanceTracking) {
        performance.startReading("Setup of classifier");
      }
      ImageClassifier classifier;
      switch (data.imageModel) {
        case ImageModelEnum.efficientNetB4:
        classifier = ImageClassifierEfficientNetB4();
          break;

        case ImageModelEnum.mobileNetV3Large:
          classifier = ImageClassifierMobileNetV3();
          break;

        default:
          classifier = ImageClassifierMobileNetV3();
          break;
      }
      logger.logger.info("Image Classifier using model: ${data.imageModel}");
      if (data.isPerformanceTracking) {
        var key = "Setup of classifier";
        performance.addReading(performance.parentKey, key, performance.stopReading(key));
      }

      int step = 1;
      int offset = data.offset ?? 0;
      int limit = step;
      var taggedCount = 0;
      var isDone = false;
      if (data.isPerformanceTracking) {
        performance.startReading("Loading of images");
      }
      var images = mediaRepo.getImagesForTaggingPagination(offset, limit);
      if (data.isPerformanceTracking) {
        var key = "Loading of images";
        performance.addReading(performance.parentKey, key, performance.stopReading(key));
      }

      aux(List<ImageDocument> images) {
        for (var image in images) {
          try {
            if (data.isPerformanceTracking) {
              performance.startReading("Classify Image");
            }
            var mediaTags = classifier.predict(image.uri, 5, percentageThreshold: 0.6);
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
          } on Exception catch (e, s) {
            image.mediaTagScores = ["NULL"];
            image.mediaTags = "NULL";
            logger.logger.shout("Exception in image classifier with message: $e", e, s);
          }
        }

        // TODO-Lukas
        if (data.isPerformanceTracking) performance.startReading("Update Repo");
        mediaRepo.updateImages(images);
        if (data.isPerformanceTracking) {
          performance.addReading(
              performance.parentKey, "Update Repo", performance.stopReading("Update Repo"));
          performance.startReading("Update Repo");
        }
        mainSendPort.send(MainImageClassifyProgressPackage(amountTagged: step, isDone: false));
        offset += step;
        taggedCount += step;
      }

      while (images.isNotEmpty && !isDone) {
        aux(images);

        if (data.isPerformanceTracking) {
          performance.startReading("Loading of images");
        }
        images = mediaRepo.getImagesForTaggingPagination(offset, limit);
        if (data.isPerformanceTracking) {
          var key = "Loading of images";
          performance.addReading(performance.parentKey, key, performance.stopReading(key));
        }

        if (data.limit != null && taggedCount > data.limit!) {
          isDone = true;
        }
      }

      if (isDone) {
        aux(images);
      }

      if (data.isPerformanceTracking) {
        performance.addData(performance.parentKey,
            duration: performance.stopReading(performance.parentKey));
      }

      classifier.dispose();

      mainSendPort.send(MainImageClassifyProgressPackage(
        amountTagged: step,
        isDone: true,
        performanceDataPoint:
            data.isPerformanceTracking ? jsonEncode(performance.parentDataPoint.toMap()) : "",
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
  int? offset;
  bool isPerformanceTracking;
  ImageModelEnum imageModel;

  IsolateImageClassifyStartPackage({
    required this.waultarPath,
    this.limit,
    this.offset,
    required this.isPerformanceTracking,
    required this.imageModel,
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
