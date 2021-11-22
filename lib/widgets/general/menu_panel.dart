import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';

import 'menu_screens.dart';

class MenuPanel extends StatefulWidget {
  const MenuPanel({Key? key}) : super(key: key);

  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  var active = MenuScreens.dashboard;
  late ThemeProvider themeProvider;

  Widget menuItem(IconData icon, MenuScreens view, {VoidCallback? onPressed}) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextButton(
        onPressed: onPressed ??
            () {
              active != view;
              setState(() {});
            },
        style: active != view
            ? ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
              )
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    themeProvider.themeMode().buttonColor),
                elevation: MaterialStateProperty.all(5),
                side: MaterialStateProperty.all(BorderSide(
                    color: themeProvider.themeMode().buttonColor, width: 1)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                shadowColor: MaterialStateProperty.all(
                    themeProvider.themeMode().shadowColor)),
        child: Icon(icon,
            color: active != view
                ? themeProvider.themeMode().secondaryColor
                : themeProvider.themeMode().iconColor),
      ),
    );
  }

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
                      height: 5,
                      thickness: 2,
                      color: themeProvider.themeMode().secondaryColor)),
              SizedBox(height: 10),
              menuItem(FontAwesomeIcons.adjust, MenuScreens.darkmode,
                  onPressed: () async {
                await themeProvider.toggleThemeData();
                setState(() {});
              }),
              SizedBox(height: 10),
              menuItem(
                FontAwesomeIcons.arrowLeft,
                MenuScreens.signout,
              ),
              SizedBox(height: 22.5),
            ],
          ),
        ],
      ),
    );
  }
}
