import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';


// creates a tmp Hive database in the testing folder
void initialiseHive() async {
  var path = Directory.current.path;
  Hive.init(path);
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

      await Hive.openBox('settings');
      var settingsBox = Hive.box('settings');
      var expected = true;
      var actual = settingsBox.isEmpty;

      expect(actual, expected);
      expect(settingsBox.length, 0);
    });
    
    test('given default settings returns darkmode is false', () async {
      
      await Hive.openBox('settings');
      var settingBox = Hive.box('settings');
      settingBox.put('darkmode', true);

      expect(true, settingBox.get('darkmode'));
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

