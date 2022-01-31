import 'dart:io';

import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/repositories/image_dao.dart';
import 'package:waultar/data/repositories/appsettings_dao.dart';
import 'package:waultar/domain/services/settings_service.dart';
import 'package:waultar/domain/services/sqlite_service.dart';

// package:waultar/data/repositories/appsettings_dao.dart

final locator = GetIt.instance;

Future<void> setupServices({bool testing = false}) async {

  // configure on startup the correct sqlite binary to use
  SqliteService().init();

  // when correct sqlite binary have initialized, register the db
  testing
      ? locator.registerSingleton<WaultarDb>(WaultarDb.testing(NativeDatabase.memory()))
      : locator.registerSingleton<WaultarDb>(WaultarDb());

  var db = locator<WaultarDb>();

  // settingsBox will be registered before SettingsService, to make the injection possible
  locator.registerSingleton<AppSettingsDao>(db.appSettingsDao, instanceName: 'appSettingsDao');
  locator.registerSingleton<ImageDao>(db.imageDao, instanceName: 'imageDao');

  // services used throughout the app
  locator.registerSingleton<IAppSettingsService>(AppSettingsService(),
      instanceName: 'appSettingsService');
}
