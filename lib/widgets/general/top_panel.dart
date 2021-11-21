import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'menu_screens.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  var settings = false;

  Widget searchBar() {
    return Container(
        padding: EdgeInsets.all(10),
        height: 40,
        decoration: BoxDecoration(
            color: Color(0xFF272B30), borderRadius: BorderRadius.circular(12)),
        child: Row(children: const [
          Icon(
            Icons.search,
            color: Color(0xFF65696F),
            size: 20,
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 250,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search or type a command',
                hintStyle: TextStyle(
                  color: Color(0xFF65696F),
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
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
                backgroundColor: MaterialStateProperty.all(Color(0xFF272B30)),
                elevation: MaterialStateProperty.all(5),
                side: MaterialStateProperty.all(
                    BorderSide(color: Color(0xFF272B30), width: 1)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                shadowColor: MaterialStateProperty.all(Color(0xFF000000))),
        child: Icon(FontAwesomeIcons.cog,
            color: !settings ? Color(0xFF65696F) : Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width - 85,
        color: const Color(0xFF1A1D1F),
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
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.darken),
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
