import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';

class DarkModeSwitch extends StatefulWidget {
  DarkModeSwitch({Key? key}) : super(key: key);

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitch();
}

class _DarkModeSwitch extends State<DarkModeSwitch> {
  bool isLightTheme = true;

  toggleThemeData() async {
    isLightTheme = !isLightTheme;
    setState(() {});
  }

  ThemeColor themeMode({double? width}) {
    return ThemeColor(
      gradient: [
        if (isLightTheme) ...[Color(0xDDFF0080), Color(0xDDFF8C00)],
        if (!isLightTheme) ...[Color(0xFF8983F7), Color(0xFFA3DAFB)]
      ],
      textColor: isLightTheme ? Color(0xFF000000) : Color(0xFFFFFFFF),
      toggleButtonColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFf34323d),
      toggleBackgroundColor: isLightTheme ? Color(0xFFe7e7e8) : Color(0xFF222029),
      toggleIconColor: isLightTheme ? Color(0xFF006BD4) : Color(0xFFECD820),
      shadow: [
        if (isLightTheme)
          BoxShadow(
              color: const Color(0xFFd8d7da),
              spreadRadius: width != null ? width * 0.005 : 5,
              blurRadius: width != null ? width * 0.01 : 10,
              offset: width != null ? Offset(0, (width * 0.005)) : const Offset(0, 5)),
        if (!isLightTheme)
          BoxShadow(
              color: const Color(0x66000000),
              spreadRadius: width != null ? width * 0.005 : 5,
              blurRadius: width != null ? width * 0.01 : 10,
              offset: width != null ? Offset(0, (width * 0.005)) : const Offset(0, 5)),
      ],
      backgroundColor: isLightTheme ? Color(0xFF000000) : Color(0xFFFFFFFF),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = 300; //can be moved as input??
    return Container(
      width: width * .3,
      height: width * .13,
      child: GestureDetector(
        onTap: () {
          toggleThemeData();
        },
        child: Container(
            width: width * .25,
            height: width * .15,
            decoration: ShapeDecoration(
                color: themeMode().toggleBackgroundColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * .04))),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .01, vertical: width * .01),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: EdgeInsets.only(right: width * .03),
                        child: Icon(
                          Iconic.sun_inv,
                          color: Color(0xFF918f95),
                          size: width * .06,
                        ),
                      ),
                      //Padding(padding: EdgeInsets.symmetric(horizontal: width * .025)),
                      Padding(
                        padding: EdgeInsets.only(left: width * .03),
                        child: Icon(
                          Iconic.moon_inv,
                          color: Color(0xFF918f95),
                          size: width * .06,
                        ),
                      ),
                    ])),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .01, vertical: width * .01),
                    child: AnimatedAlign(
                      alignment: isLightTheme ? Alignment.centerLeft : Alignment.centerRight,
                      duration: Duration(milliseconds: 350),
                      curve: Curves.ease,
                      child: Container(
                        alignment: Alignment.center,
                        width: width * .14,
                        height: width * .15,
                        decoration: ShapeDecoration(
                            color: themeMode().toggleButtonColor,
                            shadows: themeMode(width: width).shadow,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(width * .04))),
                        child: Icon(
                          isLightTheme ? Iconic.sun_inv : Iconic.moon_inv,
                          size: width * .07,
                          color: themeMode().toggleIconColor,
                        ),
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}

class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color toggleIconColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor({
    required this.gradient,
    required this.backgroundColor,
    required this.toggleBackgroundColor,
    required this.toggleButtonColor,
    required this.textColor,
    required this.shadow,
    required this.toggleIconColor,
  });
}
