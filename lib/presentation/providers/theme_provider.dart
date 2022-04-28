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

  // Global theme data we always check if the light theme is enabled #isLightTheme
  ThemeData themeData() {
    return ThemeData(
      fontFamily: 'Poppins', //inter for body?
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.grey,
      primaryColor: isLightTheme
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF272837), //widget color,
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: isLightTheme
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF1E1D2B), //background

      textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white,
            //fontFamily: "Poppins",
            fontSize: 14,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500),

        // TextStyle(
        //   color:
        //       isLightTheme ? const Color(0xFF65696F) : const Color(0xFFE0E0E0),
        //   fontFamily: "Poppins",
        //   fontSize: 15,
        //   fontWeight: FontWeight.w600,
        // ),
        headline2: TextStyle(
          color:
              isLightTheme ? const Color(0xFF65696F) : const Color(0xFFE0E0E0),
          //fontFamily: "Poppins",

          fontSize: 16,
        ),
        headline3: TextStyle(
            color: isLightTheme
                ? const Color(0xFF65696F)
                : const Color(0xFFFFFFFF),
            //fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.w500),
        headline4: const TextStyle(
            color: Color.fromARGB(255, 149, 150, 159), //Color(0xFFAEAFBB),
            //fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w500),
        bodyText1: const TextStyle(
            color: Colors.pink,
            fontSize: 12,
            fontWeight: FontWeight.w400), //not used
        bodyText2: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.2),
      ),
    );
  }

  PersonalTheme themeMode() {
    return PersonalTheme(
        themeColor: const Color(0xFF3975FB), //const Color(0xFF02A9F2),
        iconColor:
            isLightTheme ? const Color(0xFF65696F) : const Color(0xFFE0E0E0),
        secondaryColor:
            isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF272837),
        highlightColor:
            isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF363747),
        tonedColor:
            isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF424354),
        iconSize: 12,
        menuHeaderStyle: const TextStyle(
            color: Color(0xFFAEAFBB),
            //fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w400),
        tonedTextColor: const Color(0xFFAEAFBB));
  }
}

//Add additional references that doesn't exist in themedata
class PersonalTheme {
  Color themeColor;
  Color iconColor;
  Color secondaryColor;
  Color highlightColor;
  Color tonedColor;
  TextStyle menuHeaderStyle;
  Color tonedTextColor;
  double iconSize;

  PersonalTheme(
      {required this.themeColor,
      required this.iconColor,
      required this.secondaryColor,
      required this.highlightColor,
      required this.tonedColor,
      required this.iconSize,
      required this.menuHeaderStyle,
      required this.tonedTextColor});
}
