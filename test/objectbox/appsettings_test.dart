import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/startup.dart';
import '../test_helper.dart';

Future<void> main() async {
  late IAppSettingsRepository _repo;

  setUpAll(() async {
    await TestHelper.runStartupScript();
    _repo = locator.get<IAppSettingsRepository>(instanceName: 'appSettingsRepo');
  });

  tearDownAll(() async {
    await TestHelper.tearDownServices();
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
