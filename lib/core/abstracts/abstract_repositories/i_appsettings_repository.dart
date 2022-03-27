import 'package:waultar/core/models/misc/appsettings_model.dart';

abstract class IAppSettingsRepository {
  Stream<AppSettingsModel> watchSettings();
  AppSettingsModel getSettings();
  Future updateSettings(AppSettingsModel appSettings);
}
