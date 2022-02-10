import 'package:flutter/material.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/startup.dart';

class ThemeProvider with ChangeNotifier {
  final IAppSettingsService _settingsService =
      locator<IAppSettingsService>(instanceName: 'appSettingsService');

  late bool isLightTheme; // = false;

  loadTheme() {
    isLightTheme = _settingsService.getDarkMode();
  }

  ThemeProvider() {
    loadTheme();
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
      primaryColor: isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF161819), //Color(0xFF1A1D1F),
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: isLightTheme ? const Color(0xFFEEEEEE) : const Color(0xFF111315),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: isLightTheme ? const Color(0xFF65696F) : const Color(0xFFE0E0E0),
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        headline2: TextStyle(
          color: isLightTheme ? const Color(0xFF65696F) : const Color(0xFFE0E0E0),
          fontFamily: "Poppins",
          fontSize: 16,
        ),
        headline3: TextStyle(
            color: isLightTheme ? const Color(0xFF65696F) : const Color(0xFFE0E0E0),
            fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.w500),
        bodyText1: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w500),
        bodyText2: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
      ),
    );
  }

  PersonalTheme themeMode() {
    return PersonalTheme(
      buttonColor: isLightTheme ? const Color.fromARGB(255, 236, 236, 236) : const Color(0xFF272B30),
      themeColor: Colors.blue,
      iconColor: isLightTheme ? const Color(0xFF65696F) : const Color(0xFFE0E0E0),
      iconSize: 12,
      bodyText3: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
      bodyText4: TextStyle(
          color: isLightTheme ? const Color(0xFF65696F) : const Color(0xFFE0E0E0),
          fontSize: 14,
          fontWeight: FontWeight.w400),
      widgetBackground: isLightTheme ? const Color(0xFFEEEEEE) : const Color(0xff252728),
      highlightedPrimary: isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF1C1E1F), //0xFF262a2d),
    );
  }
}

//Add additional references that doesn't exist in themedata
class PersonalTheme {
  Color buttonColor;
  Color themeColor;
  Color iconColor;
  double iconSize;
  TextStyle bodyText3;
  TextStyle bodyText4;
  Color widgetBackground;
  Color highlightedPrimary;

  PersonalTheme(
      {required this.buttonColor,
      required this.themeColor,
      required this.iconColor,
      required this.iconSize,
      required this.bodyText3,
      required this.bodyText4,
      required this.widgetBackground,
      required this.highlightedPrimary});
}
