import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/drift_config.dart';

import 'package:waultar/startup.dart';

Future<void> main() async {
  late WaultarDb db;
  await setupServices(testing: true);

  setUpAll(() {
    db = locator<WaultarDb>();
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Test that DAOs can be invoked', () {
    test('given new db returns darkmode deafult value is false', () async {
      final _dao = db.appSettingsDao;

      final userSettings = await _dao.getSettings();
      expect(userSettings.darkmode, false);

      // final created = await dao.getTodoByIdAsFuture(1);
      // expect(created.title, 'Setup drift');
    });

    test('given true updates darkmode', () async {
      final _dao = db.appSettingsDao;
      var model = AppSettingsModel(true);

      bool updated = await _dao.updateSettings(model);
      expect(updated, true);

      final userSettings = await _dao.getSettings();
      expect(userSettings.darkmode, true);
    });
  });
}
