import 'package:remove_emoji/remove_emoji.dart';

import 'dart:convert';

import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_translator_service.dart';
import 'package:waultar/core/ai/sentiment_classifier_textClassification.dart';

import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';

import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
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
  final _performance = locator.get<PerformanceHelper>(instanceName: 'performance');

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
      Function(String message, bool isDone) callback, bool translate) async {
    if (ISPERFORMANCETRACKING) {
      var key = "Classify text all";
      _performance.init(newParentKey: key);
      _performance.startReading(key);
    }

    var initiator = IsolateSentimentStartPackage(
      waultarPath: locator.get<String>(instanceName: 'waultar_root_directory'),
      aiFolder: locator.get<String>(instanceName: 'ai_folder'),
      categoriesIds: categories.map((e) => e.id).toList(),
      translate: translate,
      isPerformanceTracking: ISPERFORMANCETRACKING,
    );

    _listenSentimentClassify(dynamic data) {
      switch (data.runtimeType) {
        case MainSentimentClassifyProgressPackage:
          data as MainSentimentClassifyProgressPackage;
          callback("", data.isDone);

          if (data.isDone) {
            if (ISPERFORMANCETRACKING) {
              _performance.startReading("Bucket repo update");
            }
            _bucketsRepo.updateForSentiments(
              categories.first.profile.target!,
            );
            if (ISPERFORMANCETRACKING) {
              _performance.addReading(_performance.parentKey, "Bucket repo update",
                  _performance.stopReading("Bucket repo update"));
              _performance.addData(_performance.parentKey,
                  duration: _performance.stopReading(_performance.parentKey),
                  childs: [PerformanceDataPoint.fromMap(jsonDecode(data.performanceDataPoint!))]);
              _performance.summary("Sentiment classification");
            }
          }
      }
    }

    var classifyWorker = BaseWorker(
      initiator: initiator,
      mainHandler: _listenSentimentClassify,
    );
    classifyWorker.init(sentimentWorkerBody);

    var updated = 0;
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
