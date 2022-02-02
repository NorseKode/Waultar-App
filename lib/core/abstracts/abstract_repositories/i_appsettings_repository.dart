import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/drift_config.dart';

abstract class IAppSettingsRepository {
  Stream<AppSettingsModel> watchSettings();
  Future<AppSettingsModel> getSettings();
  Future<bool> updateSettings(AppSettingsEntityCompanion appSettings);
}