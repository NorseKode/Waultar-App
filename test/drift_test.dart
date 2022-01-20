import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/db/configs/drift_config.dart';

import 'package:waultar/services/startup.dart';


Future<void> main() async {
  late WaultarDb db;
  await setupServices(testing: true);

  setUp(() {
    db = locator<WaultarDb>();
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Test that DAOs can be invoked', () {
    
    test('given new db returns darkmode deafult value is false', () async {

      final _dao = db.userSettingsDao;
      

      final userSettings = await _dao.getSettings();
      expect(userSettings.darkmode, false);

      // final created = await dao.getTodoByIdAsFuture(1);
      // expect(created.title, 'Setup drift');

    });

    test('given true updates darkmode', () async {

      final _dao = db.userSettingsDao;
      const companion = UserAppSettingsCompanion(darkmode: Value(true));

      bool updated = await _dao.updateSettings(companion);
      expect(updated, true);

      final userSettings = await _dao.getSettings();
      expect(userSettings.darkmode, true);
      
    });

  });

}