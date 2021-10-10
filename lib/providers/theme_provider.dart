import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({required this.isLightTheme});

  toggleThemeData() async {
    isLightTheme = !isLightTheme;
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
