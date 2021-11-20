import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waultar/models/settings.dart';


// creates a tmp Hive database in the testing folder
void initialiseHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(SettingsAdapter());
}
void main() {

  // run before each test case
  // setUp(() async {
  //  initialiseHive();
  // });

  // run once before any test case, and do not run for the following test cases
  setUpAll(() async {
    initialiseHive();
  });

  group('test sample', () {


    test('given new database has no settings set', () async {

      await Hive.openBox<Settings>('settings');
      var settingsBox = Hive.box<Settings>('settings');
      var expected = true;
      var actual = settingsBox.isEmpty;

      expect(actual, expected);
      expect(settingsBox.length, 0);
    });
    
    test('given default settings returns darkmode is false', () async {
      
      await Hive.openBox<Settings>('settings');
      var settingBox = Hive.box<Settings>('settings');
      Settings setting = Settings();
      settingBox.add(setting);

      expect(setting, settingBox.getAt(0));
      expect(false, settingBox.getAt(0)?.darkModeEnabled);
    });

  });
  
  // tear down once after all test cases
  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  // tear down after each test case
  // tearDown(() async {
  //   await Hive.deleteFromDisk();
  // });    
}

