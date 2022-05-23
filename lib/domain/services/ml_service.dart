import 'dart:convert';
import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/extensions/norsekode_int_extension.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/configs/globals/image_model_enum.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/ai/image_classifier_efficient_net_b4.dart';
import 'package:waultar/core/ai/image_classifier_mobilenetv3.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/domain/workers/image_classifier_worker.dart';
import 'package:waultar/startup.dart';

class MLService extends IMLService {
  final _performance = locator.get<PerformanceHelper>(instanceName: 'performance');
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');

  @override
  Future<void> classifyImagesSeparateThread({
    required Function(String message, bool isDone) callback,
    required int totalAmountOfImagesToTag,
    int threadCount = 1,
    int? limitAmount,
    required ImageModelEnum imageModel,
  }) async {
    var isDoneCount = 0;
    var amountTaggedSummed = 0;
    var amountToProcess = limitAmount ?? totalAmountOfImagesToTag;
    if (amountToProcess < 50) threadCount = 1;
    var splitList = amountToProcess.splitEqualOffsetLimit(splits: threadCount);
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

          if (data.isDone) {
            isDoneCount++;
          } else {
            if (amountTaggedSummed < amountToProcess) {
              amountTaggedSummed += data.amountTagged;
            }
            callback(
              "$amountTaggedSummed/${limitAmount ?? totalAmountOfImagesToTag} Images Tagged",
              false,
            );
          }

          if (isDoneCount == threadCount) {
            for (var worker in workersList) {
              worker.dispose();
            }

            _mediaRepo.setIsProcessed();

            if (ISPERFORMANCETRACKING) {
              _performance.addData(
                _performance.parentKey,
                duration: _performance.stopReading(_performance.parentKey),
                childs: data.performanceDataPoint != null && data.performanceDataPoint!.isNotEmpty
                    ? [PerformanceDataPoint.fromMap(jsonDecode(data.performanceDataPoint!))]
                    : [],
                metadata: {
                  "threadCount": threadCount,
                  "tagged count": totalAmountOfImagesToTag,
                },
              );
              _performance.summary("Tagging of images only total");
            }

            callback("Initializing", true);
          }
      }
    }

    var waultarPath = locator.get<String>(instanceName: 'waultar_root_directory');
    for (var i = 0; i < threadCount; i++) {
      var worker = BaseWorker(
        mainHandler: _listenImageClassify,
        initiator: IsolateImageClassifyStartPackage(
          waultarPath: waultarPath,
          offset: splitList[i].item1,
          limit: splitList[i].item2,
          isPerformanceTracking: ISPERFORMANCETRACKING,
          imageModel: imageModel,
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

  @override
  List<Tuple2<String, double>> classifySingleImage({required File imageFile, required ImageModelEnum imageModel}) {
    ImageClassifier classifier;
    
    switch (imageModel) {
      case ImageModelEnum.mobileNetV3Large:
        classifier = ImageClassifierMobileNetV3();
        break;
      case ImageModelEnum.efficientNetB4:
        classifier = ImageClassifierEfficientNetB4();
        break;

      default:
        classifier = ImageClassifierMobileNetV3();
        break;        
    }

    return classifier.predict(imageFile.path, 5);
  }

}
