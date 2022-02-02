import 'dart:io';
import 'dart:ffi';
import 'package:sqlite3/open.dart';
import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_image_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/domain/services/appsettings_service.dart';

final locator = GetIt.instance;

Future<void> setupServices({bool testing = false}) async {

  // configure on startup the correct sqlite binary to use
  configureSQLiteBinaries();

  // when correct sqlite binary have initialized, register the db
  testing
      ? locator.registerSingleton<WaultarDb>(
          WaultarDb.testing(NativeDatabase.memory()))
      : locator.registerSingleton<WaultarDb>(WaultarDb());

  var db = locator<WaultarDb>();

  locator.registerSingleton<IAppSettingsRepository>(db.appSettingsDao,
      instanceName: 'appSettingsDao');
  locator.registerSingleton<IImageRepository>(db.imageDao, instanceName: 'imageDao');

  locator.registerSingleton<IAppSettingsService>(AppSettingsService(),
      instanceName: 'appSettingsService');
}

void configureSQLiteBinaries() {
  open.overrideFor(OperatingSystem.windows, _openOnWindows);
}

DynamicLibrary _openOnWindows() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript =
      File('${scriptDir.path}/lib/assets/sqlite/sqlite3.dll');
  return DynamicLibrary.open(libraryNextToScript.path);
}

  // TODO : make override for linux as well
  // should be the same as for windows but with a sqlite3.so binary instead
  // just place the .so file in assets next to the .dll
