import 'dart:convert';

import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_translator_service.dart';

import 'package:waultar/core/ai/sentiment_classifier.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
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
  // final _textClassifier =
  //     locator.get<SentimentClassifier>(instanceName: 'sentimentClassifier');
  final _translator = locator.get<ITranslatorService>(
    instanceName: 'translator',
  );
  final _bucketsRepo = locator.get<IBucketsRepository>(
    instanceName: 'bucketsRepo',
  );

  @override
  Future<void> connotateAllTextSeparateThreadFromDB() {
    // TODO: implement connotateAllTextSeparateThreadFromDB
    throw UnimplementedError();
  }

  @override
  double connotateText(String text) {
    return 1;
  }

  @override
  Future<void> connotateOwnTextsFromCategory(List<DataCategory> categories,
      Function(String message, bool isDone) callback, bool translate) async {
    var initiator = IsolateSentimentStartPackage(
      waultarPath: locator.get<String>(instanceName: 'waultar_root_directory'),
      aiFolder: locator.get<String>(instanceName: 'ai_folder'),
      categoriesIds: categories.map((e) => e.id).toList(),
      translate: translate,
      isPerformanceTracking: ISTRACKALL,
    );

    _listenSentimentClassify(dynamic data) {
      switch (data.runtimeType) {
        case MainSentimentClassifyProgressPackage:
          data as MainSentimentClassifyProgressPackage;

          callback("", data.isDone);
          if (data.isDone) {
            print('sentiment is done');
            _bucketsRepo.updateForSentiments(
              categories.first.profile.target!,
            );
          }
      }
    }

    var classifyWorker = BaseWorker(
      initiator: initiator,
      mainHandler: _listenSentimentClassify,
    );
    classifyWorker.init(sentimentWorkerBody);

    // var username = "";
    // var profileName = categories.first.profile.target!.name;
    // var profileData = categories.first.profile.target!.categories
    //     .firstWhere((element) => element.category == CategoryEnum.profile)
    //     .dataPointNames
    //     .forEach((element) {
    //   if (element.name == "profile user") {
    //     element.dataPoints.forEach((element) {
    //       username = ((element.asMap["string_map_data"])["Username"])["value"];
    //     });
    //   }
    // });

    // // if (ISPERFORMANCETRACKING) {
    // //   performance.reInit(newParentKey: "sentimentanal");
    // //   performance.start("sentimentanal");
    // // }

    var updated = 0;
    // for (var category in categories) {
    //   List<DataPoint> dataPoints = _dataRepo.readAllFromCategory(category);
    //   for (var point in dataPoints) {
    //     var isOwnData = _isOwnData(point, username, profileName);

    //     if (point.sentimentText == null) continue;

    //     // if (ISPERFORMANCETRACKING) performance.startReading("classify");
    //     var text = await _translator.translate(
    //         input: point.sentimentText!, outputLanguage: 'en');
    //     if (text.length > 256) text = text.substring(0, 256);
    //     var sentimentScore = _textClassifier.classify(text);
    //     // if (ISPERFORMANCETRACKING) {
    //     //   performance.addReading("sentimentanal", "classify");
    //     // }
    //     point.sentimentScore = sentimentScore.last; //0-1
    //     _dataRepo.addDataPoint(point);
    //     updated++;
    //   }
    // }

    // // if (ISPERFORMANCETRACKING) {
    // //   performance.addParentReading();
    // //   performance.summary("sentimentanal");
    // // }
  }

  bool _isOwnData(DataPoint point, String profileUsername, String profileName) {
    switch (point.category.target!.category) {
      case CategoryEnum.messaging:
        if (point.asMap["sender name"] == profileUsername) {
          return true;
        }
        return false;

      default:
        return true;
    }
  }

  @override
  List<ProfileDocument> getAllProfiles() {
    return _profileRepo.getAll();
  }
}
