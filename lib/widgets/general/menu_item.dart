import 'package:flutter/material.dart';
import 'package:waultar/providers/theme_provider.dart';
import 'package:waultar/widgets/general/menu_screens.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
      required this.icon,
      required this.active,
      required this.themeProvider,
      this.onPressed})
      : super(key: key);

  final IconData icon;
  final bool active;
  final ThemeProvider themeProvider;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextButton(
        onPressed: onPressed ?? () {},
        style: !active
            ? ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
              )
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    themeProvider.themeMode().buttonColor),
                //elevation: MaterialStateProperty.all(5),
                // side: MaterialStateProperty.all(BorderSide(
                //     color: themeProvider.themeMode().buttonColor, width: 1)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                // shadowColor: MaterialStateProperty.all(
                //     themeProvider.themeMode().shadowColor)
              ),
        child: Icon(icon,
            size: 20,
            color: !active
                ? themeProvider.themeMode().secondaryColor
                : themeProvider.themeMode().iconColor),
      ),
    );
  }
}
