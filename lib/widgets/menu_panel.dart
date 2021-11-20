import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'menu_screens.dart';

class MenuPanel extends StatefulWidget {
  const MenuPanel({Key? key}) : super(key: key);

  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  var active = MenuScreens.dashboard;

  Widget menuItem(IconData icon, MenuScreens view) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextButton(
        onPressed: () {
          setState(() {
            active = view;
          });
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1A1D1F),
      width: 80,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'lib/assets/graphics/Logo.png',
                  ),
                ),
              ),
              SizedBox(height: 10),
              menuItem(FontAwesomeIcons.chartBar, MenuScreens.dashboard),
              SizedBox(height: 10),
              menuItem(FontAwesomeIcons.gem, MenuScreens.datacollection),
              SizedBox(height: 10),
              menuItem(FontAwesomeIcons.images, MenuScreens.imagelibrary),
              SizedBox(height: 10),
              menuItem(FontAwesomeIcons.questionCircle, MenuScreens.support),
            ],
          ),
          Column(
            children: [
              Container(
                  width: 45,
                  child: Divider(
                      height: 5, thickness: 2, color: Color(0xFF65696F))),
              SizedBox(height: 10),
              menuItem(FontAwesomeIcons.adjust, MenuScreens.darkmode),
              SizedBox(height: 10),
              menuItem(FontAwesomeIcons.arrowLeft, MenuScreens.signout),
              SizedBox(height: 22.5),
            ],
          ),
        ],
      ),
    );
  }
}
