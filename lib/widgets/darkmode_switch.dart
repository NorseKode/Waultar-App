// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DarkModeSwitch extends StatefulWidget {
  DarkModeSwitch({Key? key}) : super(key: key);

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitch();
}

class _DarkModeSwitch extends State<DarkModeSwitch> {
  bool isLightTheme = true;
  final List<String> values = ['Light', 'Dark'];
  final List<IconData> valueIcons = [MdiIcons.brightness5, MdiIcons.brightness3];

  toggleThemeData() async {
    isLightTheme = !isLightTheme;
    setState(() {});
  }

  // Global theme data we are always check if the light theme is enabled #isLightTheme
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

  ThemeColor themeMode() {
    return ThemeColor(
      gradient: [
        if (isLightTheme) ...[Color(0xDDFF0080), Color(0xDDFF8C00)],
        if (!isLightTheme) ...[Color(0xFF8983F7), Color(0xFFA3DAFB)]
      ],
      textColor: isLightTheme ? Color(0xFF000000) : Color(0xFFFFFFFF),
      toggleButtonColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFf34323d),
      toggleBackgroundColor: isLightTheme ? Color(0xFFe7e7e8) : Color(0xFF222029),
      shadow: [
        if (isLightTheme)
          BoxShadow(
              color: Color(0xFFd8d7da), spreadRadius: 5, blurRadius: 10, offset: Offset(0, 5)),
        if (!isLightTheme)
          BoxShadow(color: Color(0x66000000), spreadRadius: 5, blurRadius: 10, offset: Offset(0, 5))
      ],
      backgroundColor: isLightTheme ? Color(0xFF000000) : Color(0xFFFFFFFF),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .5,
      height: width * .13,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              toggleThemeData();
            },
            child: Container(
              width: width * .5,
              height: width * .13,
              decoration: ShapeDecoration(
                  color: themeMode().toggleBackgroundColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * .1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .1),
                    child: Icon(
                      valueIcons[index],
                      color: Color(0xFF918f95),
                      size: width * .05,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            alignment: isLightTheme ? Alignment.centerLeft : Alignment.centerRight,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease,
            child: Container(
              alignment: Alignment.center,
              width: width * .25,
              height: width * .13,
              decoration: ShapeDecoration(
                  color: themeMode().toggleButtonColor,
                  shadows: themeMode().shadow,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * .1))),
              child: Icon(
                isLightTheme ? valueIcons[0] : valueIcons[1],
                size: width * .045,
              ),
            ),
          )
        ],
      ),
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

  ThemeColor({
    required this.gradient,
    required this.backgroundColor,
    required this.toggleBackgroundColor,
    required this.toggleButtonColor,
    required this.textColor,
    required this.shadow,
  });
}
