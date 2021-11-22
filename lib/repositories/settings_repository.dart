import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsRepository {
  
  LazyBox _box;

  SettingsRepository(this._box);

  ValueListenable getDarkModeListenable() => _box.listenable();

  Future<void> toogleDarkMode() async
  {
    bool toogled = await _box.get('darkmode');
    _box.put('darkmode', toogled);
  }

}