import 'package:flutter/material.dart';
import 'package:waultar/services/service_locator.dart';
import 'package:waultar/services/settings_service.dart';

class ThemeProvider with ChangeNotifier {
  final SettingsService _settingsService = locator<SettingsService>();

  late bool isLightTheme;

  ThemeProvider() {
    isLightTheme = _settingsService.getDarkMode();
  }



  
  toggleDarkmode() async {
    isLightTheme = !isLightTheme;
    _settingsService.toogleDarkMode(isLightTheme);
    notifyListeners();
  }

  ThemeData themeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
      primaryColor: isLightTheme ? Colors.white : Color(0xFF1E1F28),
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      backgroundColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF26242e),
      scaffoldBackgroundColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF26242e),
    );
  }
}

class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor(
    this.gradient,
    this.backgroundColor,
    this.toggleBackgroundColor,
    this.toggleButtonColor,
    this.textColor,
    this.shadow,
  );
}
