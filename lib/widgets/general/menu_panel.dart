import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';
import 'package:waultar/widgets/general/menu_item.dart';

import 'menu_screens.dart';

class MenuPanel extends StatefulWidget {
  const MenuPanel({Key? key}) : super(key: key);

  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  var active = MenuScreens.dashboard;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      color: themeProvider.themeData().primaryColor,
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
                    color: themeProvider.themeMode().iconColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              MenuItem(
                active: active == MenuScreens.dashboard ? true : false,
                icon: FontAwesomeIcons.chartBar,
                themeProvider: themeProvider,
                onPressed: () {
                  active = MenuScreens.dashboard;
                  setState(() {});
                },
              ),
              // SizedBox(height: 10),
              // MenuItem(
              //   active: active == MenuScreens.datacollection ? true : false,
              //   icon: FontAwesomeIcons.gem,
              //   themeProvider: themeProvider,
              //   onPressed: () {
              //     active = MenuScreens.datacollection;
              //     setState(() {});
              //   },
              // ),
              // SizedBox(height: 10),
              // MenuItem(
              //   active: active == MenuScreens.imagelibrary ? true : false,
              //   icon: FontAwesomeIcons.images,
              //   themeProvider: themeProvider,
              //   onPressed: () {
              //     active = MenuScreens.imagelibrary;
              //     setState(() {});
              //   },
              // ),
              // SizedBox(height: 10),
              // MenuItem(
              //   active: active == MenuScreens.support ? true : false,
              //   icon: FontAwesomeIcons.questionCircle,
              //   themeProvider: themeProvider,
              //   onPressed: () {
              //     active = MenuScreens.support;
              //     setState(() {});
              //   },
              // ),
            ],
          ),
          Column(
            children: [
              Container(
                  width: 38,
                  child: Divider(
                      height: 5,
                      thickness: 2,
                      color: themeProvider.themeMode().secondaryColor)),
              SizedBox(height: 10),
              MenuItem(
                active: active == MenuScreens.settings ? true : false,
                icon: FontAwesomeIcons.cog,
                themeProvider: themeProvider,
                onPressed: () {
                  active = MenuScreens.settings;
                  setState(() {});
                },
              ),
              SizedBox(height: 10),
              MenuItem(
                active: false,
                icon: FontAwesomeIcons.arrowLeft,
                themeProvider: themeProvider,
              ),
              SizedBox(height: 22.5),
            ],
          ),
        ],
      ),
    );
  }
}
