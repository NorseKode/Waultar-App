import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/repositories/user_settings_dao.dart';
import 'package:waultar/startup.dart';

class SettingsService {
  final Box settingsBox = locator<Box>(instanceName: 'settingsBox');

  SettingsService() {
    seedWithDefaultIfEmpty();
  }

  void toogleDarkMode(bool darkMode) => settingsBox.put('darkmode', darkMode);

  bool getDarkMode() => settingsBox.get('darkmode');

  ValueListenable listenForDarkmode() => settingsBox.listenable(keys: ['darkmode']);

  bool isBoxEmpty() => settingsBox.isEmpty;

  bool isBoxOpen() => settingsBox.isOpen;

  int getLengthOfBox() => settingsBox.length;

  void seedWithDefaultIfEmpty() {
    if (settingsBox.isEmpty) {
      settingsBox.put('darkmode', false);
      settingsBox.put('firstTimeUser', true);
    } else {
      return;
    }
  }
}

abstract class IAppSettingsService {
  Future<bool> getDarkMode();
  Future toogleDarkMode(bool darkMode);
}

class AppSettingsService implements IAppSettingsService {
  final _dao = locator<UserSettingsDao>(instanceName: 'appSettingsDao');

  @override
  Future<bool> getDarkMode() async {
    var settings = await _dao.getSettings();
    return settings.darkmode;
  }

  @override
  Future toogleDarkMode(bool darkMode) async {
    var result = await _dao.updateSettings(UserAppSettingsCompanion(darkmode: Value(darkMode)));
    if (!result) {
      // no entry updated, errormessage or something here
    }
  }
}
