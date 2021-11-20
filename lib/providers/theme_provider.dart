import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({required this.isLightTheme});

  // use to toggle the theme
  toggleThemeData() async {
    //final settings = await Hive.openBox('settings');
    //settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
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
