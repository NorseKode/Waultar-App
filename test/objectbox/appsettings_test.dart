import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/models/index.dart';

import 'package:waultar/startup.dart';

Future<void> main() async {
  late IAppSettingsRepository _repo;
  await setupServices(testing: true);

  setUpAll(() {
    _repo = locator<IAppSettingsRepository>(instanceName: 'appSettingsRepo');
  });

  tearDownAll(() async {
    // await db.close();
  });

  group('Test that repo can be invoked', () {
    test('given new db returns darkmode deafult value is false', () async {
      final userSettings = _repo.getSettings();
      expect(userSettings.darkmode, false);
      expect(userSettings.id, 1);
    });

    test('given true updates darkmode', () async {
      final userSettings = _repo.getSettings();
      userSettings.darkmode = true;

      await _repo.updateSettings(userSettings);

      final userSettingsUpdated = _repo.getSettings();
      expect(userSettingsUpdated.darkmode, true);
    });
  });
}
