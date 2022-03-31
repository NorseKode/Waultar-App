import 'dart:convert';

import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/ai/sentiment_classifier.dart';
import 'package:waultar/core/helpers/performance_helper2.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/domain/workers/image_classifier_worker.dart';
import 'package:waultar/domain/workers/shared_packages.dart';
import 'package:waultar/startup.dart';

class MLService extends IMLService {
  final _performance = locator.get<PerformanceHelper2>(instanceName: 'performance2');

  @override
  Future<void> classifyImagesSeparateThread(
    {
    required Function(String message, bool isDone) callback, 
    required int totalAmountOfImagesToTag,
    int? limitAmount,
  }) async {
    var amountTaggedSummed = 0;

    if (ISPERFORMANCETRACKING) {
      var key = "Classifying of images";
      _performance.reInit(newParentKey: key);
      _performance.start(key);
    }

    var initiator = IsolateImageClassifyStartPackage(
      waultarPath: locator.get<String>(instanceName: 'waultar_root_directory'),
      aiFolder: locator.get<String>(instanceName: 'ai_folder'),
      limit: limitAmount,
      isPerformanceTracking: ISTRACKALL,
    );

    _listenImageClassify(dynamic data) {
      switch (data.runtimeType) {
        case MainPerformanceMeasurementPackage:
          data as MainPerformanceMeasurementPackage;
          if (ISTRACKALL) {
            var performanceDataPoint = PerformanceDataPoint.fromMap(
              jsonDecode(data.performanceDataPointJson),
            );
            _performance.storeDataPoint("Classifying of images", performanceDataPoint);
          }
          break;

        case MainImageClassifyProgressPackage:
          data as MainImageClassifyProgressPackage;
          amountTaggedSummed += data.amountTagged;
          callback("$amountTaggedSummed/${limitAmount ?? totalAmountOfImagesToTag} Images Tagged", data.isDone);
          if (ISPERFORMANCETRACKING && data.isDone) {
            _performance.addParentReading(
                childs: _performance.getStoredDataPoints(_performance.parentKey),
                metadata: {
                  "Step": 1,
                  "Device": "Lukas' Desktop",
                  "Notes": "Only ran all",
                  "Link to dataset": "https://1drv.ms/u/s!AmvKrTBSZGTNisdzGf8k0XE9EzKGmA?e=7B13wv",
                });
            _performance.summary("Tagging of images only total");
          }
      }
    }

    var classifyWorker = BaseWorker(initiator: initiator, mainHandler: _listenImageClassify);
    classifyWorker.init(imageClassifierWorkerBody);
  }

  @override
  int classifyImage() {
    // TODO: implement classifyImage
    throw UnimplementedError();
  }

  @override
  int classifyImagesFromDB() {
    // if (ISPERFORMANCETRACKING) {
    //   _performance.reInit(newParentKey: "imageTagging", newChildKey: "image");
    //   _performance.start();
    // }

    // var startTime = DateTime.now();

    // int updated = 0;
    // int step = 100;
    // int offset = 0;
    // int limit = step;
    // var images = _mediaRepo.getImagesPagination(offset, limit);

    // while (images.isNotEmpty) {
    //   for (var image in images) {
    //     var mediaTags = _classifier.predict(image.uri, 5);

    //     if (mediaTags.length == 0) {
    //       image.mediaTagScores = ["No Tag Found"];
    //       image.mediaTags = "No Tag Found";
    //     }

    //     image.mediaTagScores = mediaTags.map((e) => ",(${e.item1},${e.item2})").toList();

    //     image.mediaTags =
    //         mediaTags.fold<String>("", (previous, next) => previous += ",${next.item1}");

    //     updated++;
    //   }

    //   _mediaRepo.updateImages(images);
    //   offset += step;
    //   images = _mediaRepo.getImagesPagination(offset, limit);
    // }

    // if (ISPERFORMANCETRACKING) {
    //   _performance.stopParentAndWriteToFile(
    //     "image-tagging",
    //     metadata: {"Image count": updated},
    //   );
    // }

    // return updated;
    throw UnimplementedError();
  }
}
