import 'dart:io';
import 'package:path/path.dart' as dart_path;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:waultar/configs/globals/helper/performance_helper.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_utility_repostitory.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_collections_service.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/media_repo.dart';
import 'package:waultar/core/inodes/profile_repo.dart';
import 'package:waultar/core/inodes/service_repo.dart';
import 'package:waultar/core/inodes/tree_parser.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/ai/sentiment_classifier.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/ai/image_classifier_mobilenetv3.dart';
import 'package:waultar/core/inodes/util_repo.dart';
import 'package:waultar/core/ai/sentiment_classifier_textClassification.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/repositories/appsettings_repo.dart';
import 'package:waultar/domain/services/appsettings_service.dart';
import 'package:waultar/domain/services/collections_service.dart';
import 'package:waultar/domain/services/ml_service.dart';
import 'configs/globals/app_logger.dart';
import 'configs/globals/os_enum.dart';

final locator = GetIt.instance;
late final OS os;
late final ObjectBox _context;
late final AppLogger _logger;

late final String _waultarPath;
late final String _dbFolderPath;
late final String _extractsFolderPath;
late final String _logFolderPath;
late final String _performanceFolderPath;

Future<void> setupServices() async {
  await initApplicationPaths().whenComplete(() async {
    locator.registerSingleton<String>(_waultarPath, instanceName: 'waultar_root_directory');
    locator.registerSingleton<String>(_dbFolderPath, instanceName: 'db_folder');
    locator.registerSingleton<String>(_extractsFolderPath, instanceName: 'extracts_folder');
    locator.registerSingleton<String>(_logFolderPath, instanceName: 'log_folder');
    locator.registerSingleton<String>(_performanceFolderPath, instanceName: 'performance_folder');

    os = detectPlatform();
    locator.registerSingleton<OS>(os, instanceName: 'platform');

    _logger = AppLogger(os, _logFolderPath);
    locator.registerSingleton<AppLogger>(_logger, instanceName: 'logger');

    locator.registerSingleton<PerformanceHelper>(
      PerformanceHelper(
        pathToPerformanceFile: _performanceFolderPath,
        parentKey: "",
      ),
      instanceName: 'performance',
    );

    // create objectbox at startup
    // this MUST be the only context throughout runtime
    // await Future.delayed(const Duration(seconds: 5), () async {
    _context = await ObjectBox.create(_dbFolderPath);
    // });
    locator.registerSingleton<ObjectBox>(_context, instanceName: 'context');

    // register all abstract repositories with their concrete implementations
    // each repo gets injected the context (to access the relevant store)
    // and the objectboxDirector to map from models to entities
    locator.registerSingleton<IAppSettingsRepository>(AppSettingsRepository(_context),
        instanceName: 'appSettingsRepo');
    locator.registerSingleton<IServiceRepository>(ServiceRepository(_context),
        instanceName: 'serviceRepo');
    // locator.registerSingleton<ITimeBucketsRepository>(
    //     TimeBucketsRepository(_context),
    //     instanceName: 'timeRepo');
    locator.registerSingleton<IUtilityRepository>(UtilityRepository(_context),
        instanceName: 'utilsRepo');
    locator.registerSingleton<ProfileRepository>(ProfileRepository(_context),
        instanceName: 'profileRepo');

    final _categoryRepo = DataCategoryRepository(_context);
    final _nameRepo = DataPointNameRepository(_context);
    final _dataRepo = DataPointRepository(_context);

    locator.registerSingleton<DataCategoryRepository>(_categoryRepo, instanceName: "categoryRepo");
    locator.registerSingleton<DataPointNameRepository>(_nameRepo, instanceName: "nameRepo");
    locator.registerSingleton<DataPointRepository>(_dataRepo, instanceName: "dataRepo");
    locator.registerSingleton<MediaRepository>(
      MediaRepository(_context),
      instanceName: 'mediaRepo',
    );

    // AI Models
    locator.registerSingleton<ImageClassifier>(
      ImageClassifierMobileNetV3(),
      instanceName: 'imageClassifier',
    );

    locator.registerSingleton<SentimentClassifier>(
      SentimentClassifierTextClassifierTFLite(),
      instanceName: 'sentimentClassifier',
    );

    // register all services and inject their dependencies
    locator.registerSingleton<IAppSettingsService>(AppSettingsService(),
        instanceName: 'appSettingsService');
    locator.registerSingleton<ICollectionsService>(
        CollectionsService(_categoryRepo, _nameRepo, _dataRepo),
        instanceName: 'collectionsService');
    locator.registerSingleton<TreeParser>(TreeParser(_categoryRepo, _nameRepo, _dataRepo),
        instanceName: 'parser');
    locator.registerSingleton<IMLService>(MLService(), instanceName: 'mlService');

    // locator.registerSingleton<ITimelineService>(
    //     TimeLineService(
    //         locator.get<ITimeBucketsRepository>(instanceName: 'timeRepo')),
    //     instanceName: 'timeService');
  });
}

OS detectPlatform() {
  if (Platform.isWindows) {
    return OS.windows;
  }

  if (Platform.isLinux) {
    return OS.linux;
  }

  if (Platform.isMacOS) {
    return OS.macos;
  }

  if (Platform.isAndroid) {
    return OS.android;
  }

  if (Platform.isIOS) {
    return OS.ios;
  }

  if (kIsWeb) {
    return OS.web;
  }

  throw Exception('Could not detect platform');
}

Future initApplicationPaths() async {
  final _documentsDirectory = await getApplicationDocumentsDirectory();

  _waultarPath = dart_path.normalize(_documentsDirectory.path + '/waultar/');
  _dbFolderPath = dart_path.normalize(_waultarPath + '/objectbox/');
  _extractsFolderPath = dart_path.normalize(_waultarPath + '/extracts/');
  _logFolderPath = dart_path.normalize(_waultarPath + '/logs/');
  _performanceFolderPath = dart_path.normalize(_waultarPath + '/performance/');

  var dbFolderDir = Directory(_dbFolderPath);
  var extractsFolderDir = Directory(_extractsFolderPath);
  var logFolderDir = Directory(_logFolderPath);

  var extractsFolderExists = await extractsFolderDir.exists();
  if (!extractsFolderExists) {
    await extractsFolderDir.create(recursive: true);
  }
  var logFolderExists = await logFolderDir.exists();
  if (!logFolderExists) {
    await logFolderDir.create(recursive: true);
  }
  var dbFolderExists = await dbFolderDir.exists();
  if (!dbFolderExists) {
    await dbFolderDir.create(recursive: true);
  }
}


// DynamicLibrary _openOnWindows() {
//   final scriptDir = File(Platform.script.toFilePath()).parent;
//   final libraryNextToScript = File(
//       dart_path.normalize('${scriptDir.path}/lib/assets/sqlite/sqlite3.dll'));
//   return DynamicLibrary.open(libraryNextToScript.path);
// }

// DynamicLibrary _openOnLinux() {
//   final scriptDir = File(Platform.script.toFilePath()).parent;
//   final libraryNextToScript =
//       File('${scriptDir.path}/lib/assets/sqlite/sqlite3.so');
//   return DynamicLibrary.open(libraryNextToScript.path);
// }
