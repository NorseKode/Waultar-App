import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:waultar/services/startup.dart';

class SettingsService {

  final Box settingsBox = locator<Box>(instanceName: 'settingsBox');

  void toogleDarkMode(bool darkMode) => settingsBox.put('darkmode', darkMode);

  bool getDarkMode() => settingsBox.get('darkmode');

  ValueListenable listenForDarkmode() => settingsBox.listenable(keys: ['darkmode']);

  bool isBoxEmpty() => settingsBox.isEmpty;

  bool isBoxOpen() => settingsBox.isOpen;

  int getLengthOfBox() => settingsBox.length;
  
}