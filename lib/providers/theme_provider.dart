import 'package:flutter/material.dart';
import 'package:waultar/services/startup.dart';
import 'package:waultar/services/settings_service.dart';

class ThemeProvider with ChangeNotifier {
  final SettingsService _settingsService = locator<SettingsService>();

  late bool isLightTheme;

  ThemeProvider() {
    isLightTheme = _settingsService.getDarkMode();
  }

  
  toggleThemeData() async {
    isLightTheme = !isLightTheme;
    _settingsService.toogleDarkMode(isLightTheme);
    notifyListeners();
  }

  // Global theme data we are always check if the light theme is enabled #isLightTheme
  ThemeData themeData() {
    return ThemeData(
      fontFamily: 'Inter',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
      primaryColor: Color(0xff2196F3),
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      backgroundColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF111315),
      scaffoldBackgroundColor:
          isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF111315),
    );
  }
}
