import 'package:drift/drift.dart';
import 'package:waultar/core/models/appsettings_model.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/entities/appsettings_entity.dart';

part 'appsettings_dao.g.dart';

@DriftAccessor(tables: [AppSettingsEntity])
class AppSettingsDao extends DatabaseAccessor<WaultarDb> with _$AppSettingsDaoMixin {
  AppSettingsDao(WaultarDb attachedDatabase) : super(attachedDatabase);

  // MUST alwasy be 1 to adhere to the "only one row" constraint defined in the AppSettingsEntity table
  final int _key = 1;


  Stream<AppSettingsModel> watchSettings() => (select(appSettingsEntity)..where((s) => s.key.equals(_key))).watchSingle();

  Future<AppSettingsModel> getSettings() => (select(appSettingsEntity)..where((s) => s.key.equals(_key))).getSingle();

  Future<bool> updateSettings(AppSettingsEntityCompanion appSettings) async { 
    int amountOfRowsUpdated = await (update(appSettingsEntity)..where((s) => s.key.equals(_key))).write(appSettings);

    if (amountOfRowsUpdated == 1) {
      return true; 
    } else {
      return false;
    }
  }
  
}
