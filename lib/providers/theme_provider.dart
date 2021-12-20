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
      fontFamily: 'Poppins', //inter for body?
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.grey,
      primaryColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF1A1D1F),
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      backgroundColor: isLightTheme ? Color(0xFFE0E0E0) : Color(0xFF111315),
      scaffoldBackgroundColor:
          isLightTheme ? Color.fromARGB(255, 238, 238, 238) : Color(0xFF111315),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: isLightTheme ? Color(0xFF65696F) : Color(0xFFE0E0E0),
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        headline2: TextStyle(
          color: isLightTheme ? Color(0xFF65696F) : Color(0xFFE0E0E0),
          fontFamily: "Poppins",
          fontSize: 16,
        ),
        headline3: TextStyle(
            color: isLightTheme ? Color(0xFF65696F) : Color(0xFFE0E0E0),
            fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.w500),
        bodyText1: const TextStyle(
            color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w500),
        bodyText2: const TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
      ),
    );
  }

  PersonalTheme themeMode() {
    return PersonalTheme(
      buttonColor:
          isLightTheme ? Color.fromARGB(255, 236, 236, 236) : Color(0xFF272B30),
      shadowColor: Color(0xFF000000),
      secondaryColor: Color(0xFF65696F),
      themeColor: Colors.blue,
      iconColor: isLightTheme ? Color(0xFF65696F) : Color(0xFFE0E0E0),
      iconSize: 12,
      bodyText3: const TextStyle(
          color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
    );
  }
}

//Add additional references that doesn't exist in themedata
class PersonalTheme {
  Color buttonColor;
  Color secondaryColor;
  Color themeColor;
  Color iconColor;
  Color shadowColor;
  double iconSize;
  TextStyle bodyText3;

  PersonalTheme(
      {required this.buttonColor,
      required this.shadowColor,
      required this.secondaryColor,
      required this.themeColor,
      required this.iconColor,
      required this.iconSize,
      required this.bodyText3});
}
