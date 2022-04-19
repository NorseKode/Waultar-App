import 'dart:convert';
import 'dart:io';

import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_utility_repostitory.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_name_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:path/path.dart' as dart_path;
import 'package:waultar/startup.dart';

class PresentationHelper {
  static final IUtilityRepository _utilsRepo =
      locator.get<IUtilityRepository>(instanceName: 'utilsRepo');
  static final BaseLogger _appLogger =
      locator.get<BaseLogger>(instanceName: 'logger');
  // static final _appSettingsRepo =
  //     locator.get<IAppSettingsRepository>(instanceName: 'appSettingsRepo');
  // static final _serviceRepo = locator.get<IServiceRepository>(instanceName: 'serviceRepo');
  static final _profileRepo = locator.get<ProfileRepository>(instanceName: 'profileRepo');
  static final _categoryRepo = locator.get<DataCategoryRepository>(instanceName: "categoryRepo");
  static final _nameRepo = locator.get<DataPointNameRepository>(instanceName: "nameRepo");
  static final _dataRepo = locator.get<DataPointRepository>(instanceName: "dataRepo");
  static final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
  static final _bucketsRepo = locator.get<IBucketsRepository>(instanceName: 'bucketsRepo');
  static final _fileSavePath = locator.get<String>(instanceName: 'performance_folder');

  static void logDatabase() {
    _appLogger.logger.info('DB log statistics:');
    _appLogger.logger.info(
        'Total categories  -> ${_utilsRepo.getTotalCountCategories().toString()}');
    _appLogger.logger.info(
        'Total name nodes  -> ${_utilsRepo.getTotalCountDataNames().toString()}');
    _appLogger.logger.info(
        'Total datapoints  -> ${_utilsRepo.getTotalCountDataPoints().toString()}');
    _appLogger.logger.info(
        'Total images      -> ${_utilsRepo.getTotalCountImages().toString()}');
    _appLogger.logger.info(
        'Total videos      -> ${_utilsRepo.getTotalCountVideos().toString()}');
    _appLogger.logger.info(
        'Total files       -> ${_utilsRepo.getTotalCountFiles().toString()}');
    _appLogger.logger.info(
        'Total links       -> ${_utilsRepo.getTotalCountLinks().toString()}');
    _appLogger.logger.info('Category names and counts:');
    for (var category in _utilsRepo.getAllCategories()) {
      _appLogger.logger.info('${category.category.name} -> ${category.count}');
    }
  }

  static void nukeDatabase() {
    _appLogger.logger
        .info("Entities deleted: " + _utilsRepo.nukeAll().toString());
    _appLogger.logger.info("Nuke database => removed all elements");
  }

  static void dumpDbAsJson() {
    _writeEntitiesToJsonFile("profiles",
        jsonEncode(_profileRepo.getAll().map((e) => e.toMap()).toList()));
    _writeEntitiesToJsonFile("dataPoints",
        jsonEncode(_dataRepo.readAll().map((e) => e.toMap()).toList()));
    _writeEntitiesToJsonFile(
        "dataCategories",
        jsonEncode(
            _categoryRepo.getAllCategories().map((e) => e.toMap()).toList()));
    _writeEntitiesToJsonFile("dataPointNames",
        jsonEncode(_nameRepo.getAll().map((e) => e.toMap()).toList()));
    _writeEntitiesToJsonFile(
        "dayBuckets",
        jsonEncode(
            _bucketsRepo.getAllDayBuckets().map((e) => e.toMap()).toList()));
    _writeEntitiesToJsonFile(
        "monthBuckets",
        jsonEncode(
            _bucketsRepo.getAllMonthBuckets().map((e) => e.toMap()).toList()));
    _writeEntitiesToJsonFile(
        "yearBuckets", jsonEncode(_bucketsRepo.getAllYearBuckets().map((e) => e.toMap()).toList()));
    _writeEntitiesToJsonFile(
        "images", jsonEncode(_mediaRepo.getAllImages().map((e) => e.toMap()).toList()));
  }

  static void _writeEntitiesToJsonFile(String filename, String entitiesJson) {
    var file = File(
      dart_path.normalize(
        dart_path.join(
          _fileSavePath,
          "$filename.json",
        ),
      ),
    );

    file.createSync(recursive: true);
    // file.writeAsStringSync(entitiesJson);
    file.writeAsBytesSync(utf8.encode(entitiesJson));
  }

  static void deleteAllSentimentScores() {
    var updatedDataPoints = _dataRepo.readAll().map<DataPoint>((e) {
      e.sentimentScore = null;

      return e;
    }).toList();
    _dataRepo.addMany(updatedDataPoints);
  }
}
