import 'dart:io';

import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/repositories/image_dao.dart';
import 'package:waultar/data/repositories/user_settings_dao.dart';
import 'package:waultar/domain/services/settings_service.dart';
import 'package:waultar/domain/services/sqlite_service.dart';

final locator = GetIt.instance;

Future<void> setupServices({bool testing = false}) async {
  testing ? Hive.init('/test/') : await Hive.initFlutter();

  // configure on startup the correct sqlite binary to use
  SqliteService().init();

  // when correct sqlite binary have initialized, register the db
  testing
      ? locator.registerSingleton<WaultarDb>(WaultarDb.testing(NativeDatabase.memory()))
      : locator.registerSingleton<WaultarDb>(WaultarDb());

  var db = locator<WaultarDb>();

  // settingsBox will be registered before SettingsService, to make the injection possible
  locator.registerSingleton<UserSettingsDao>(db.userSettingsDao, instanceName: 'appSettingsDao');
  locator.registerSingleton<ImageDao>(db.imageDao, instanceName: 'imageDao');

  // services used throughout the app
  locator.registerSingleton<IAppSettingsService>(AppSettingsService(),
      instanceName: 'appSettingsService');
}
