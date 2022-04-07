import 'dart:convert';
import 'dart:isolate';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_translator_service.dart';
import 'package:waultar/core/ai/image_classifier_mobilenetv3.dart';
import 'package:waultar/core/ai/sentiment_classifier.dart';
import 'package:waultar/core/ai/sentiment_classifier_textClassification.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:path/path.dart' as dart_path;
import 'package:waultar/startup.dart';

Future sentimentWorkerBody(dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is IsolateSentimentStartPackage) {
    try {
      await setupIsolate(mainSendPort, data, data.waultarPath);
      var _logger = locator.get<BaseLogger>(instanceName: 'logger');
      var performance = locator.get<PerformanceHelper>(instanceName: 'performance');
      var categoryRepo = locator.get<DataCategoryRepository>(instanceName: 'categoryRepo');
      var dataRepo = locator.get<DataPointRepository>(instanceName: 'dataRepo');
      var translator = locator.get<ITranslatorService>(instanceName: 'translator');
      var sentimentClassifier =
          SentimentClassifierTextClassifierTFLite(aiFolderPath: data.aiFolder);

      var categories = data.categoriesIds.map((e) => categoryRepo.getCategoryById(e)!).toList();

      var username = "";
      var profileName = categories.first.profile.target!.name;
      var profileData = categories.first.profile.target!.categories
          .firstWhere((element) => element.category == CategoryEnum.profile)
          .dataPointNames
          .forEach((element) {
        if (element.name == "profile user") {
          element.dataPoints.forEach((element) {
            username = ((element.asMap["string_map_data"])["Username"])["value"];
          });
        }
      });

      // if (ISPERFORMANCETRACKING) {
      //   performance.reInit(newParentKey: "sentimentanal");
      //   performance.start("sentimentanal");
      // }

      bool _isOwnData(DataPoint point, String profileUsername, String profileName) {
        switch (point.category.target!.category) {
          case CategoryEnum.messaging:
            if (point.asMap["sender_name"] == profileUsername) {
              return true;
            }
            return false;

          default:
            return true;
        }
      }

      _logger.logger.info("Started sentiment scoring of ${data.categoriesIds.length} categories");

      for (var category in categories) {
        List<DataPoint> dataPoints = dataRepo.readAllFromCategory(category);
        for (var point in dataPoints) {
          var isOwnData = _isOwnData(point, username, profileName);

          if (isOwnData && point.sentimentText != null && point.sentimentText!.isNotEmpty) {
            // if (ISPERFORMANCETRACKING) performance.startReading("classify");
            var text = point.sentimentText!;
            // await translator.translate(
            //     input: point.sentimentText!, outputLanguage: 'en');
            if (text.length > 256) text = text.substring(0, 256);
            var sentimentScore = sentimentClassifier.classify(text);
            // if (ISPERFORMANCETRACKING) {
            //   performance.addReading("sentimentanal", "classify");
            // }
            point.sentimentScore = sentimentScore.last; //0-1
            dataRepo.addDataPoint(point);

            _logger.logger
                .info("Gave DataPoint with id ${point.id} a score of ${point.sentimentScore}");
          } else {
            _logger.logger.info("DataPoint with id: ${point.id} had a sentiment text that was either null, empty or not the users data");          }
        }
      }

      _logger.logger.info("Finished sentiment scoring");

      mainSendPort.send(MainSentimentClassifyProgressPackage(amountTagged: 0, isDone: true));
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

class IsolateSentimentStartPackage extends InitiatorPackage {
  String waultarPath;
  String aiFolder;
  List<int> categoriesIds;
  bool isPerformanceTracking;

  IsolateSentimentStartPackage({
    required this.waultarPath,
    required this.aiFolder,
    required this.categoriesIds,
    required this.isPerformanceTracking,
  });
}

class MainSentimentClassifyProgressPackage {
  int amountTagged;
  bool isDone;
  String? performanceDataPoint;

  MainSentimentClassifyProgressPackage({
    required this.amountTagged,
    required this.isDone,
    this.performanceDataPoint,
  });
}
