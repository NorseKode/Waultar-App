import 'dart:convert';

import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/domain/workers/image_classifier_worker.dart';
import 'package:waultar/startup.dart';

class MLService extends IMLService {
  final _performance = locator.get<PerformanceHelper>(instanceName: 'performance');

  @override
  Future<void> classifyImagesSeparateThread({
    required Function(String message, bool isDone) callback,
    required int totalAmountOfImagesToTag,
    int threadCount = 1,
    int? limitAmount,
  }) async {
    var isDoneCount = 0;
    var amountTaggedSummed = 0;
    var amountToProcess = limitAmount ?? totalAmountOfImagesToTag;
    var splitCount = amountToProcess ~/ threadCount;
    var workersList = <BaseWorker>[];

    if (ISPERFORMANCETRACKING) {
      var key = "Classifying of images";
      _performance.init(newParentKey: key);
      _performance.startReading(key);
    }

    _listenImageClassify(dynamic data) {
      switch (data.runtimeType) {
        case MainImageClassifyProgressPackage:
          data as MainImageClassifyProgressPackage;
          amountTaggedSummed += data.amountTagged;

          if (data.isDone) isDoneCount++;

          callback("$amountTaggedSummed/${limitAmount ?? totalAmountOfImagesToTag} Images Tagged",
              isDoneCount == threadCount);
          if (ISPERFORMANCETRACKING && isDoneCount == threadCount) {
            _performance.addData(
              _performance.parentKey,
              duration: _performance.stopReading(_performance.parentKey),
              childs: data.performanceDataPoint != null && data.performanceDataPoint!.isNotEmpty
                  ? [PerformanceDataPoint.fromMap(jsonDecode(data.performanceDataPoint!))]
                  : [],
              metadata: {"threadCount": threadCount},
            );
            _performance.summary("Tagging of images only total");

            for (var worker in workersList) {
              worker.dispose();
            }
          }
      }
    }

    var waultarPath = locator.get<String>(instanceName: 'waultar_root_directory');
    for (var i = 0; i < threadCount; i++) {
      var worker = BaseWorker(
        mainHandler: _listenImageClassify,
        initiator: IsolateImageClassifyStartPackage(
          waultarPath: waultarPath,
          offset: splitCount * i,
          limit: i != threadCount - 1 ? (splitCount * (i + 1)) : amountToProcess,
          isPerformanceTracking: false,
        ),
      );

      workersList.add(worker);
      worker.init(imageClassifierWorkerBody);
    }
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
