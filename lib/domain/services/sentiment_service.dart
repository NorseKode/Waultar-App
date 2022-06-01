import 'dart:convert';

import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_translator_service.dart';
import 'package:waultar/core/ai/sentiment_classifier_textClassification.dart';
import 'package:waultar/configs/extensions/norsekode_int_extension.dart';

import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';

import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/domain/workers/sentiment_worker.dart';
import 'package:waultar/startup.dart';

class SentimentService extends ISentimentService {
  final _dataRepo = locator.get<DataPointRepository>(
    instanceName: 'dataRepo',
  );
  final _profileRepo = locator.get<ProfileRepository>(
    instanceName: 'profileRepo',
  );
  final _categoryRepo = locator.get<DataCategoryRepository>(
    instanceName: 'categoryRepo',
  );
  final _translator = locator.get<ITranslatorService>(
    instanceName: 'translator',
  );
  final _bucketsRepo = locator.get<IBucketsRepository>(
    instanceName: 'bucketsRepo',
  );
  final _performance =
      locator.get<PerformanceHelper>(instanceName: 'performance');

  var sentimentClassifier = SentimentClassifierTextClassifierTFLite();

  Map<int, int> categoryCountMap = {};

  @override
  Map<int, int> get categoryCount => categoryCountMap;

  @override
  Future<void> connotateAllTextSeparateThreadFromDB() {
    throw UnimplementedError();
  }

  @override
  double connotateText(String text) {
    return sentimentClassifier.classify(text).last;
  }

  @override
  Future<void> connotateOwnTextsFromCategory(List<DataCategory> categories,
      Function(String message, bool isDone) callback, bool translate,
      {int threadCount = 0}) async {
    if (ISPERFORMANCETRACKING) {
      var key = "Classify text all";
      _performance.init(newParentKey: key);
      _performance.startReading(key);
    }

    var isDoneCount = 0;
    var progressCount = 0;
    var workers = <BaseWorker>[];
    var totalCount = categories.fold<int>(
        0, (previousValue, element) => previousValue += element.count);
    var profiles = categories.fold<List<ProfileDocument>>(<ProfileDocument>[],
        (previousValue, element) {
      if (!previousValue.contains(element.profile.target)) {
        previousValue.add(element.profile.target!);
      }

      return previousValue;
    });

    var messagesOnIsolates = categories
        .where((element) =>
            // element.category == CategoryEnum.messaging && element.count > 30000)
            element.category == CategoryEnum.messaging)
        .toList();

    categories.removeWhere((element) => messagesOnIsolates.contains(element));

    var initiator = IsolateSentimentStartPackage(
      waultarPath: locator.get<String>(instanceName: 'waultar_root_directory'),
      aiFolder: locator.get<String>(instanceName: 'ai_folder'),
      categoriesIds: categories.map((e) => e.id).toList(),
      translate: translate,
      isPerformanceTracking: false,
    );

    _listenSentimentClassify(dynamic data) {
      switch (data.runtimeType) {
        case MainSentimentClassifyProgressPackage:
          data as MainSentimentClassifyProgressPackage;
          progressCount += data.amountTagged;

          if (progressCount < totalCount) {
            callback("$progressCount/$totalCount text analysed", false);
          }

          if (data.isDone) {
            isDoneCount++;
          }

          if (isDoneCount == threadCount && progressCount >= totalCount) {
            for (var worker in workers) {
              worker.sendMessage(IsolateSentimentDisposePackage());
              worker.dispose();
            }

            if (ISPERFORMANCETRACKING) {
              _performance.startReading("Bucket repo update");
            }
            for (var profile in profiles) {
              _bucketsRepo.updateForSentiments(profile);
            }
            if (ISPERFORMANCETRACKING) {
              _performance.addReading(
                  _performance.parentKey,
                  "Bucket repo update",
                  _performance.stopReading("Bucket repo update"));
              _performance.addData(_performance.parentKey,
                  duration: _performance.stopReading(_performance.parentKey),
                  metadata: {
                    'totalCount': totalCount,
                    'isolateCount': threadCount,
                  });

              if (data.performanceDataPoint != null &&
                  data.performanceDataPoint!.isNotEmpty) {
                _performance.addData(
                  _performance.parentKey,
                  childs: [
                    PerformanceDataPoint.fromMap(
                        jsonDecode(data.performanceDataPoint!))
                  ],
                );
              }

              _performance.summary("Sentiment classification");
            }

            callback("Initializing", true);
          }
      }
    }

    if (categories.isNotEmpty) {
      var classifyWorker = BaseWorker(
        initiator: initiator,
        mainHandler: _listenSentimentClassify,
      );
      workers.add(classifyWorker);
      classifyWorker.init(sentimentWorkerBody);
    } else {
      threadCount--;
    }

    for (var messageData in messagesOnIsolates) {
      var threadCountTemp = 1;
      threadCount += threadCountTemp;
      var count = messageData.count;
      // var splitCount = count ~/ threadCountTemp;
      var splitList = count.splitEqualOffsetLimit(splits: threadCountTemp);

      for (var i = 0; i < threadCountTemp; i++) {
        var worker = BaseWorker(
          mainHandler: _listenSentimentClassify,
          initiator: IsolateSentimentStartPackage(
            waultarPath: locator.get<String>(instanceName: 'waultar_root_directory'),
            aiFolder: locator.get<String>(instanceName: 'ai_folder'),
            categoriesIds: [messageData.id],
            translate: translate,
            isPerformanceTracking: true,
            // isPerformanceTracking: false,
            offset: splitList[i].item1,
            limit: splitList[i].item2,
          ),
        );

        workers.add(worker);
        worker.init(sentimentWorkerBody);
      }
    }
  }

  @override
  List<ProfileDocument> getAllProfiles() {
    return _profileRepo.getAll();
  }

  @override
  void calculateCategoryCount(List<int> categories) {
    for (var categoryID in categories) {
      var entry = {
        categoryID:
            getCategoryCount(_categoryRepo.getCategoryById(categoryID)!.id),
      };
      categoryCountMap.addAll(entry);
    }
  }

  @override
  int getCategoryCount(int categoryId) {
    return _dataRepo.readAllSentimentCategory(categoryId);
  }
}
