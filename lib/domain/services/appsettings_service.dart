import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/core/models/appsettings_model.dart';
import 'package:waultar/startup.dart';

class AppSettingsService implements IAppSettingsService {
  final IAppSettingsRepository _dao = locator<IAppSettingsRepository>(instanceName: 'appSettingsDao');

  @override
  Future<bool> getDarkMode() async {
    var settings = await _dao.getSettings();
    return settings.darkmode;
  }

  @override
  Future toogleDarkMode(bool darkMode) async {
    var result = await _dao.updateSettings(AppSettingsModel(darkMode));
    if (!result) {
      // no entry updated, errormessage or something here
    }
  }
}
