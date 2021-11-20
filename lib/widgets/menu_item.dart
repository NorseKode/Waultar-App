import 'package:flutter/material.dart';

import 'menu_screens.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.active,
    required this.icon,
    required this.view,
  }) : super(key: key);

  final MenuScreens active;
  final IconData icon;
  final MenuScreens view;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextButton(
        onPressed: () {
          print("You pressed: " + view.toString());
        },
        style: active != view
            ? ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
              )
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF272B30)),
                elevation: MaterialStateProperty.all(5),
                side: MaterialStateProperty.all(
                    BorderSide(color: Color(0xFF272B30), width: 1)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                shadowColor: MaterialStateProperty.all(Color(0xFF000000))),
        child: Icon(icon,
            color: active != view ? Color(0xFF65696F) : Colors.white),
      ),
    );
  }
}
