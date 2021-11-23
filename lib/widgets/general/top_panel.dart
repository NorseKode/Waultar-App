import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';
import 'package:waultar/widgets/general/menu_item.dart';

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

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(title, style: Theme.of(context).textTheme.headline1),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width - 82,
        color: themeProvider.themeData().primaryColor,
        child: Row(
          children: [
            title("Dashboard"),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 100),
            //   child: searchBar(),
            // ),
            Expanded(child: Container()),
            MenuItem(
              onPressed: () async {
                await themeProvider.toggleThemeData();
                setState(() {});
              },
              active: false,
              icon: FontAwesomeIcons.adjust,
              themeProvider: themeProvider,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      themeProvider.themeMode().themeColor, BlendMode.darken),
                  child: Image.asset('lib/assets/graphics/Logo.png',
                      width: 40.0, height: 40.0, fit: BoxFit.fill),
                ),
              ),
            )
          ],
        ));
  }
}
