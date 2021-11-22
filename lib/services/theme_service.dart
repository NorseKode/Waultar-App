import 'package:flutter/foundation.dart';
import 'package:waultar/repositories/index.dart';

class ThemeService {

  final SettingsRepository _repo;

  ThemeService(this._repo);

  void toogleDarkMode() async
  {
    await _repo.toogleDarkMode();
  }

  ValueListenable listenForDarkmode() => _repo.getDarkModeListenable();
  
  
}