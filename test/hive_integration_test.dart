import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waultar/services/settings_service.dart';
import 'package:waultar/services/startup.dart';

void main() async {
  setUpAll(() async {
    await setupServices(testing: true);
  });

  // tear down once after all test cases
  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });


  group('test sample', () {
    test('given new database has no settings set', () async {
      SettingsService _service = locator<SettingsService>();
      var empty = _service.isBoxEmpty();
      var length = _service.getLengthOfBox();
      var darkmode = _service.getDarkMode();

      expect(empty, false);
      expect(length, 2);
      expect(darkmode, false);
    });

    test('toogle dark mode', () async {
      SettingsService _service = locator<SettingsService>();

      _service.toogleDarkMode(true);
      expect(true, _service.getDarkMode());

      _service.toogleDarkMode(false);
      expect(false, _service.getDarkMode());
    });
  });


}
