import 'package:drift/drift.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/models/appsettings_model.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/entities/appsettings_entity.dart';

import 'companion_mapper.dart';

part 'appsettings_dao.g.dart';

@DriftAccessor(tables: [AppSettingsEntity])
class AppSettingsDao extends DatabaseAccessor<WaultarDb> with _$AppSettingsDaoMixin implements IAppSettingsRepository {
  AppSettingsDao(WaultarDb attachedDatabase) : super(attachedDatabase);

  // MUST alwasy be 1 to adhere to the "only one row" constraint defined in the AppSettingsEntity table
  final int _key = 1;

  @override
  Stream<AppSettingsModel> watchSettings() => (select(appSettingsEntity)..where((s) => s.key.equals(_key))).watchSingle();

  @override
  Future<AppSettingsModel> getSettings() => (select(appSettingsEntity)..where((s) => s.key.equals(_key))).getSingle();

  @override
  Future<bool> updateSettings(AppSettingsModel appSettings) async { 
    var companion = toAppSettingsCompanion(appSettings);
    int amountOfRowsUpdated = await (update(appSettingsEntity)..where((s) => s.key.equals(_key))).write(companion);

    if (amountOfRowsUpdated == 1) {
      return true; 
    } else {
      return false;
    }
  }
  
}
