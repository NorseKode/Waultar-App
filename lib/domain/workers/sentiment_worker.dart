import 'dart:convert';
import 'dart:isolate';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_translator_service.dart';
import 'package:waultar/core/ai/sentiment_classifier_textClassification.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/startup.dart';
import 'package:remove_emoji/remove_emoji.dart';

Future sentimentWorkerBody(dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is IsolateSentimentStartPackage) {
    try {
      await setupIsolate(mainSendPort, data, data.waultarPath);
      var _logger = locator.get<BaseLogger>(instanceName: 'logger');
      var performance = locator.get<PerformanceHelper>(instanceName: 'performance');
      var categoryRepo = locator.get<DataCategoryRepository>(instanceName: 'categoryRepo');
      var dataRepo = locator.get<DataPointRepository>(instanceName: 'dataRepo');
      var translator = locator.get<ITranslatorService>(instanceName: 'translator');
      var sentimentClassifier = SentimentClassifierTextClassifierTFLite();

      if (data.isPerformanceTracking) {
        performance.init(newParentKey: "Sentiment classification");
        performance.startReading(performance.parentKey);
      }

      if (data.isPerformanceTracking) {
        performance.startReading("Setup");
      }
      var categories = data.categoriesIds.map((e) => categoryRepo.getCategoryById(e)!).toList();

      var username = "";
      var profile = categories.first.profile.target!;
      var profileData = categories.first.profile.target!.categories
          .firstWhere((element) => element.category == CategoryEnum.profile)
          .dataPointNames
          .forEach((element) {
        if (profile.service.target!.serviceName == "Instagram") {
          if (element.name == "profile user") {
            for (var point in element.dataPoints) {
              username = ((point.asMap["string_map_data"])["Username"])["value"];
            }
          }
        } else {
          if (element.name == "profile") {
            for (var pointName in element.children) {
              for (var point in pointName.dataPoints) {
                if (point.asMap.containsKey("full name")) {
                  username = point.asMap["full name"];
                }
              }
            }
          }
        }
      });
      if (data.isPerformanceTracking) {
        performance.addReading(performance.parentKey, "Setup", performance.stopReading("Setup"));
      }

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

      String _cleanText(String text) {
        var clean = RemoveEmoji().removemoji(text);
        clean = clean.replaceAll(RegExp(r'#\w+'), '');
        clean = clean.replaceAll(RegExp(r'(@(?:\w|\.)+)'), '');
        return clean;
      }

      _logger.logger.info("Started sentiment scoring of ${data.categoriesIds.length} categories");

      for (var category in categories) {
        aux(List<DataPoint> dataPoints) async {
          for (var point in dataPoints) {
            if (data.isPerformanceTracking) performance.startReading("_isOwnData");
            var isOwnData = _isOwnData(point, username, profile.name);
            if (data.isPerformanceTracking) {
              performance.addReading(
                  performance.parentKey, "_isOwnData", performance.stopReading("_isOwnData"));
            }

            if (isOwnData && point.sentimentText != null && point.sentimentText!.isNotEmpty) {
              if (data.isPerformanceTracking) performance.startReading("clean text");
              var text = "";
              if (point.sentimentText!.contains("#") || point.sentimentText!.contains("#")) {
                var text = _cleanText(point.sentimentText!);
                text = text.trim();
              } else {
                text = point.sentimentText!;
              }
              // if (text.length > 256) text = text.substring(0, 256);
              if (data.isPerformanceTracking) {
                performance.addReading(
                    performance.parentKey, "clean text", performance.stopReading("clean text"));
              }

              if (text.isNotEmpty) {
                if (data.translate) {
                  if (data.isPerformanceTracking) performance.startReading("translate");
                  text = await translator.translate(input: text, outputLanguage: 'en');
                  if (data.isPerformanceTracking) {
                    performance.addReading(
                        performance.parentKey, "translate", performance.stopReading("translate"));
                  }
                }

                if (data.isPerformanceTracking) performance.startReading("classify");
                var sentimentScore = sentimentClassifier.classify(text);
                point.sentimentScore = sentimentScore.last; //0-1
                if (data.isPerformanceTracking) {
                  performance.addReading(
                      performance.parentKey, "classify", performance.stopReading("classify"));
                }

                if (data.isPerformanceTracking) performance.startReading("repo");
                dataRepo.addDataPoint(point);
                if (data.isPerformanceTracking) {
                  performance.addReading(
                      performance.parentKey, "repo", performance.stopReading("repo"));
                }

                _logger.logger
                    .info("Gave DataPoint with id ${point.id} a score of ${point.sentimentScore}");
              } else {
                point.sentimentScore = -1;
                dataRepo.addDataPoint(point);

                _logger.logger.info("DataPoint had an empty sentiment text");
              }
            } else {
              point.sentimentScore = -1;
              dataRepo.addDataPoint(point);

              _logger.logger.info(
                  "DataPoint with id: ${point.id} had a sentiment text that was either null, empty or not the users data");
            }
          }

          mainSendPort.send(MainSentimentClassifyProgressPackage(
            amountTagged: dataPoints.length,
            isDone: false,
          ));
        }

        const step = 20;
        int offset = data.offset ?? 0;
        int limit = step;
        var isDone = false;

        List<DataPoint> dataPoints =
            dataRepo.readAllFromCategoryPagination(category, offset, limit);

        while (dataPoints.isNotEmpty && !isDone) {
          await aux(dataPoints);

          if (data.limit != null && data.limit! < (offset + step)) {
            var remaining = step - ((offset + step) - data.limit!);
            offset += remaining;
            limit = remaining;
            isDone = true;
          } else {
            offset += step;
          }

          dataPoints = dataRepo.readAllFromCategoryPagination(category, offset, limit);
        }

        if (isDone) {
          aux(dataPoints);
        }
      }

      _logger.logger.info("Finished sentiment scoring");

      if (data.isPerformanceTracking) {
        performance.addData(performance.parentKey,
            duration: performance.stopReading(performance.parentKey));
      }

      mainSendPort.send(MainSentimentClassifyProgressPackage(
        amountTagged: 0,
        isDone: true,
        performanceDataPoint:
            data.isPerformanceTracking ? jsonEncode(performance.parentDataPoint.toMap()) : "",
      ));
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
  bool translate;
  int? limit;
  int? offset;

  IsolateSentimentStartPackage({
    required this.waultarPath,
    required this.aiFolder,
    required this.categoriesIds,
    required this.isPerformanceTracking,
    required this.translate,
    this.limit,
    this.offset,
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
