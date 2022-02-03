import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/drift_config.dart';

import 'package:waultar/startup.dart';

Future<void> main() async {
  late WaultarDb db;
  late IAppSettingsRepository _repo;
  await setupServices(testing: true);

  setUpAll(() {
    db = locator<WaultarDb>();
    _repo = db.appSettingsDao;
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Test that DAOs can be invoked', () {
    test('given new db returns darkmode deafult value is false', () async {
      final userSettings = await _repo.getSettings();
      expect(userSettings.darkmode, false);
    });

    test('given true updates darkmode', () async {
      var model = AppSettingsModel(true);

      bool updated = await _repo.updateSettings(model);
      expect(updated, true);

      final userSettings = await _repo.getSettings();
      expect(userSettings.darkmode, true);
    });
  });
}
