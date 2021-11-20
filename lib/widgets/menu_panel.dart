import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'menu_item.dart';
import 'menu_screens.dart';

class MenuPanel extends StatefulWidget {
  const MenuPanel({Key? key}) : super(key: key);

  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  var active = MenuScreens.dashboard;

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
              MenuItem(
                  active: active,
                  icon: FontAwesomeIcons.chartBar,
                  view: MenuScreens.dashboard),
              SizedBox(height: 10),
              MenuItem(
                  active: active,
                  icon: FontAwesomeIcons.gem,
                  view: MenuScreens.datacollection),
              SizedBox(height: 10),
              MenuItem(
                  active: active,
                  icon: FontAwesomeIcons.images,
                  view: MenuScreens.imagelibrary),
              SizedBox(height: 10),
              MenuItem(
                  active: active,
                  icon: FontAwesomeIcons.questionCircle,
                  view: MenuScreens.support),
              SizedBox(height: 10),
              MenuItem(
                  active: active,
                  icon: FontAwesomeIcons.cog,
                  view: MenuScreens.settings),
            ],
          ),
          Column(
            children: [
              Container(
                  width: 45,
                  child: Divider(
                      height: 5, thickness: 2, color: Color(0xFF65696F))),
              SizedBox(height: 10),
              MenuItem(
                  active: active,
                  icon: FontAwesomeIcons.arrowLeft,
                  view: MenuScreens.none),
              SizedBox(height: 22.5),
            ],
          ),
        ],
      ),
    );
  }
}
