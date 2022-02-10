import 'package:waultar/core/models/index.dart';

abstract class IAppSettingsRepository {
  Stream<AppSettingsModel> watchSettings();
  AppSettingsModel getSettings();
  Future updateSettings(AppSettingsModel appSettings);
}
