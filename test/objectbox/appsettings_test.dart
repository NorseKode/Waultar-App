import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/repositories/appsettings_repo.dart';

import 'test_utils.dart';

Future<void> main() async {
  late IAppSettingsRepository _repo;
  late ObjectBox _context;
  // await setupServices(testing: true);

  setUpAll(() async {
    // _repo = locator<IAppSettingsRepository>(instanceName: 'appSettingsRepo');
    // _context = locator<ObjectBox>();
    await TestUtils.deleteTestDb();
    _context = await TestUtils.createTestDb();
    _repo = AppSettingsRepository(_context);
  });

  tearDownAll(() async {
    _context.store.close();
    await TestUtils.deleteTestDb();
  });

  group('Test that repo can be invoked', () {
    test('given new db returns darkmode deafult value is false', () async {
      final userSettings = _repo.getSettings();
      expect(userSettings.darkmode, false);
      expect(userSettings.id, 1);
    });

    test('given true updates darkmode', () async {
      var userSettings = _repo.getSettings();
      expect(userSettings.id, 1);
      expect(userSettings.darkmode, false);

      userSettings.darkmode = true;
      await _repo.updateSettings(userSettings);

      final userSettingsUpdated = _repo.getSettings();
      expect(userSettingsUpdated.darkmode, true);
    });
  });
}
