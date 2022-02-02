import 'package:flutter/material.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

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
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
              ),
        child: Icon(icon,
            size: 20,
            color: !active
                ? themeProvider.themeData().primaryColor
                : themeProvider.themeMode().iconColor),
      ),
    );
  }
}
