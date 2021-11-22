import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waultar/db/drift_config.dart';
import 'package:waultar/services/settings_service.dart';
import 'package:waultar/services/sqlite_service.dart';

final locator = GetIt.instance;

Future<void> setupServices() async 
{
  await Hive.initFlutter();
  final _settingsBox = await Hive.openBox('settings');

  // configure on startup the correct sqlite binary to use
  SqliteService().init();

  // when correct sqlite binary have initialized, register the db
  locator.registerSingleton<WaultarDb>(WaultarDb());
  locator.registerSingleton<SettingsService>(SettingsService(settingsBox: _settingsBox));

}