import 'package:waultar/core/models/index.dart';
abstract class IAppSettingsRepository {
  Stream<AppSettingsModel> watchSettings();
  Future<AppSettingsModel> getSettings();
  Future<bool> updateSettings(AppSettingsModel appSettings);
}