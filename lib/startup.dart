import 'dart:io';
import 'dart:isolate';
import 'package:path/path.dart' as dart_path;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_utility_repostitory.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_collections_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/repositories/buckets_repo.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_name_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/data/repositories/service_repo.dart';
import 'package:waultar/core/parsers/tree_parser.dart';
import 'package:waultar/data/repositories/util_repo.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/repositories/appsettings_repo.dart';
import 'package:waultar/domain/services/appsettings_service.dart';
import 'package:waultar/domain/services/collections_service.dart';
import 'package:waultar/domain/services/parser_service.dart';
import 'package:waultar/domain/services/timeline_service.dart';
import 'configs/globals/app_logger.dart';
import 'configs/globals/os_enum.dart';

final locator = GetIt.instance;
late final OS os;
late final ObjectBox _context;
late final BaseLogger _logger;

late final String _waultarPath;
late final String _dbFolderPath;
late final String _extractsFolderPath;
late final String _logFolderPath;
late final String _performanceFolderPath;
late final String _pathToAIFolder;

Future<void> setupServices({
  bool testing = false,
  bool isolate = false,
  SendPort? sendPort,
  String? waultarPath,
}) async {
  await initApplicationPaths(testing: testing, waultarPath: waultarPath).whenComplete(() async {
    locator.registerSingleton<String>(_waultarPath, instanceName: 'waultar_root_directory');
    locator.registerSingleton<String>(_dbFolderPath, instanceName: 'db_folder');
    locator.registerSingleton<String>(_extractsFolderPath, instanceName: 'extracts_folder');
    locator.registerSingleton<String>(_logFolderPath, instanceName: 'log_folder');
    locator.registerSingleton<String>(_performanceFolderPath, instanceName: 'performance_folder');
    locator.registerSingleton<String>(_pathToAIFolder, instanceName: 'ai_folder');

    os = detectPlatform();
    locator.registerSingleton<OS>(os, instanceName: 'platform');

    if (isolate) {
      _logger = IsolateLogger(sendPort!);
    } else {
      _logger = AppLogger(os);
    }
    locator.registerSingleton<BaseLogger>(_logger, instanceName: 'logger');

    locator.registerSingleton<PerformanceHelper>(
      PerformanceHelper(
        pathToPerformanceFile: _performanceFolderPath,
      ),
      instanceName: 'performance',
    );

    // create objectbox at startup
    // this MUST be the only context throughout runtime
    if (isolate) {
      _context = await ObjectBox.fromIsolate(_dbFolderPath);
    } else {
      _context = await ObjectBox.create(_dbFolderPath);
    }
    locator.registerSingleton<ObjectBox>(_context, instanceName: 'context');

    // register all abstract repositories with their concrete implementations
    // each repo gets injected the context (to access the relevant store)
    // and the objectboxDirector to map from models to entities
    locator.registerSingleton<IAppSettingsRepository>(AppSettingsRepository(_context),
        instanceName: 'appSettingsRepo');
    locator.registerSingleton<IServiceRepository>(ServiceRepository(_context),
        instanceName: 'serviceRepo');
    locator.registerSingleton<IUtilityRepository>(UtilityRepository(_context),
        instanceName: 'utilsRepo');
    locator.registerSingleton<ProfileRepository>(ProfileRepository(_context),
        instanceName: 'profileRepo');

    final _bucketsRepo = BucketsRepository(_context);
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
    locator.registerSingleton<IBucketsRepository>(_bucketsRepo, instanceName: 'bucketsRepo');

    // register all services and inject their dependencies
    locator.registerSingleton<IAppSettingsService>(
      AppSettingsService(),
      instanceName: 'appSettingsService',
    );
    locator.registerSingleton<ICollectionsService>(
      CollectionsService(_categoryRepo, _nameRepo, _dataRepo),
      instanceName: 'collectionsService',
    );
    locator.registerSingleton<TreeParser>(
      TreeParser(),
      instanceName: 'parser',
    );
    locator.registerSingleton<ITimelineService>(
      TimeLineService(_bucketsRepo),
      instanceName: 'timeService',
    );
    locator.registerSingleton<IParserService>(
      ParserService(),
      instanceName: 'parserService',
    );
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

Future initApplicationPaths({bool testing = false, String? waultarPath}) async {
  if (waultarPath != null) {
    _waultarPath = waultarPath;
  } else {
    final _documentsDirectory = waultarPath ??
        (testing
            ? File(Platform.script.toFilePath()).parent.path + '/test/'
            : (await getApplicationDocumentsDirectory()).path);

    _waultarPath = dart_path.normalize(_documentsDirectory + '/waultar/');
  }

  _dbFolderPath = dart_path.normalize(_waultarPath + '/objectbox/');
  _extractsFolderPath = dart_path.normalize(_waultarPath + '/extracts/');
  _logFolderPath = dart_path.normalize(_waultarPath + '/logs/');
  _performanceFolderPath = dart_path.normalize(_waultarPath + '/performance/');
  _pathToAIFolder = dart_path
      .normalize(
        dart_path.join(
          dart_path.dirname(Platform.script.path),
          "lib",
          "assets",
          "ai_models",
        ),
      )
      .substring(1);

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
