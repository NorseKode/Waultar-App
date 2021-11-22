import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  var settings = false;
  late ThemeProvider themeProvider;

  Widget searchBar() {
    return Container(
        padding: const EdgeInsets.all(10),
        height: 40,
        decoration: BoxDecoration(
            color: themeProvider.themeMode().buttonColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Icon(
            Icons.search,
            color: themeProvider.themeMode().secondaryColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 250,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search or type a command',
                hintStyle: TextStyle(
                  color: themeProvider.themeMode().secondaryColor,
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: themeProvider.themeData().textTheme.bodyText1!.color,
                fontSize: 15,
              ),
            ),
          )
        ]));
  }

  Widget settingsButton() {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextButton(
        onPressed: () {
          setState(() {
            settings = !settings;
          });
        },
        style: !settings
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
        child: Icon(FontAwesomeIcons.cog,
            color: !settings
                ? themeProvider.themeMode().secondaryColor
                : themeProvider.themeMode().iconColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width - 85,
        color: themeProvider.themeData().primaryColor,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: searchBar(),
            ),
            Expanded(child: Container()),
            settingsButton(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      themeProvider.themeMode().themeColor, BlendMode.darken),
                  child: Image.asset(
                    'lib/assets/graphics/Logo.png',
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
