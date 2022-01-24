import 'package:drift/drift.dart';
import 'package:waultar/db/configs/drift_config.dart';
import 'package:waultar/models/tables/index.dart';

part 'user_settings_dao.g.dart';

@DriftAccessor(tables: [UserAppSettings])
class UserSettingsDao extends DatabaseAccessor<WaultarDb> with _$UserSettingsDaoMixin {
  UserSettingsDao(WaultarDb attachedDatabase) : super(attachedDatabase);

  // MUST alwasy be 1 to adhere to the "only one row" constraint defined in the Settings table
  final int _key = 1;


  Stream<UserSettings> watchSettings() => (select(userAppSettings)..where((s) => s.key.equals(_key))).watchSingle();

  Future<UserSettings> getSettings() => (select(userAppSettings)..where((s) => s.key.equals(_key))).getSingle();

  Future<bool> updateSettings(UserAppSettingsCompanion userSettings) async { 
    int amountOfRowsUpdated = await (update(userAppSettings)..where((s) => s.key.equals(_key))).write(userSettings);

    if (amountOfRowsUpdated == 1) {
      return true; 
    } else {
      return false;
    }
  }
  
}
