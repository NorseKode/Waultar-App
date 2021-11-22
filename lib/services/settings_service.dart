import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class SettingsService {

  final Box settingsBox;

  SettingsService({required this.settingsBox});

  void toogleDarkMode(bool darkMode) => settingsBox.put('darkmode', darkMode);

  bool getDarkMode() => settingsBox.get('darkmode');

  ValueListenable listenForDarkmode() => settingsBox.listenable(keys: ['darkmode']);
  
  
}