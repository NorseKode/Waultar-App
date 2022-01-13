import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';
import 'package:waultar/widgets/general/menu_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuPanel2 extends StatefulWidget {
  const MenuPanel2({Key? key}) : super(key: key);

  @override
  _MenuPanel2State createState() => _MenuPanel2State();
}

class _MenuPanel2State extends State<MenuPanel2> {
  var active = MenuScreens.dashboard;
  late ThemeProvider themeProvider;
  double menuWidth = 200;

  Widget logo() {
    var logo = SvgPicture.asset('lib/assets/graphics/logov4.svg',
        semanticsLabel: 'waultar logo', height: 40);
    var title = SvgPicture.asset(
      'lib/assets/graphics/waultar.svg',
      semanticsLabel: 'waultar logo',
      height: 20,
      color: themeProvider.themeMode().iconColor,
    );
    return Container(
      height: 90,
      child: Row(
        children: [
          logo,
          const SizedBox(
            width: 10,
          ),
          title
        ],
      ),
    );
  }

  Widget menuIcon(String icon, bool highlight) {
    final assetName = 'lib/assets/icons/fi-rr-' + icon + '.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'menu logo: ' + icon,
      height: 15,
      color: highlight
          ? themeProvider.themeMode().themeColor
          : themeProvider.themeMode().iconColor,
    );
    return svg;
  }

  Widget menuButton(String icon, String title, MenuScreens screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Container(
        height: 30,
        width: menuWidth,
        decoration: BoxDecoration(
            border: active == screen
                ? Border(
                    right: BorderSide(
                        width: 3.0,
                        color: themeProvider.themeMode().themeColor))
                : null),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              active = screen;
              setState(() {});
            },
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(
              children: [
                menuIcon(icon, active == screen ? true : false),
                const SizedBox(width: 10),
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        color: active == screen
                            ? themeProvider.themeMode().themeColor
                            : themeProvider.themeMode().iconColor))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget analytics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.centerLeft,
            height: 30,
            child: Text("ANALYTICS",
                style: themeProvider.themeData().textTheme.bodyText1)),
        menuButton('dashboard', "Dashboard", MenuScreens.dashboard),
        menuButton('world', "Data sources", MenuScreens.datasources),
      ],
    );
  }

  Widget collections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 30,
          child: Text(
            "COLLECTIONS",
            style: themeProvider.themeData().textTheme.bodyText1,
          ),
        ),
        menuButton('picture', "Album", MenuScreens.album),
        menuButton('document', "Posts", MenuScreens.posts),
        menuButton('edit', "Comments", MenuScreens.comments)
      ],
    );
  }

  Widget profile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Container(
        height: 30,
        width: menuWidth,
        decoration: BoxDecoration(
            border: active == MenuScreens.profile
                ? Border(
                    right: BorderSide(
                        width: 3.0,
                        color: themeProvider.themeMode().themeColor))
                : null),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              active = MenuScreens.profile;
              setState(() {});
            },
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              height: 30,
              width: menuWidth,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: themeProvider.themeMode().themeColor,
                    radius: 7.5,
                  ),
                  const SizedBox(width: 10),
                  Text('John D.',
                      style: TextStyle(
                          fontSize: 12,
                          color: themeProvider.themeMode().iconColor))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget darkmodeButton() {
    return InkWell(
      onTap: () async {
        await themeProvider.toggleThemeData();
        setState(() {});
      },
      child: Container(
        height: 30,
        width: menuWidth,
        child: Row(
          children: [
            themeProvider.isLightTheme
                ? menuIcon('sun', false)
                : menuIcon('moon', false),
            const SizedBox(width: 10),
            Text('Change theme',
                style: TextStyle(
                    fontSize: 12, color: themeProvider.themeMode().iconColor))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        color: themeProvider.themeData().primaryColor,
        width: menuWidth,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  logo(),
                  analytics(),
                  SizedBox(height: 20),
                  collections(),
                  SizedBox(height: 20),
                  darkmodeButton(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profile(),
                  menuButton(
                      'settings-sliders', "Settings", MenuScreens.settings),
                  menuButton(
                      'angle-double-small-left', "Logout", MenuScreens.logout)
                ],
              ),
            ],
          ),
        ));
  }
}
