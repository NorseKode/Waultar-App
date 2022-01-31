import 'package:drift/drift.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/repositories/appsettings_dao.dart';
import 'package:waultar/startup.dart';

abstract class IAppSettingsService {
  Future<bool> getDarkMode();
  Future toogleDarkMode(bool darkMode);
}

class AppSettingsService implements IAppSettingsService {
  final _dao = locator<AppSettingsDao>(instanceName: 'appSettingsDao');

  @override
  Future<bool> getDarkMode() async {
    var settings = await _dao.getSettings();
    return settings.darkmode;
  }

  @override
  Future toogleDarkMode(bool darkMode) async {
    var result = await _dao.updateSettings(AppSettingsEntityCompanion(darkmode: Value(darkMode)));
    if (!result) {
      // no entry updated, errormessage or something here
    }
  }
}
