import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waultar/widgets/menu_item.dart';

import 'menu_screens.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
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
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'type something...',
                hintStyle: TextStyle(
                  color: Color(0xFF65696F),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          )
        ]));
  }

  Widget notificationButton() {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextButton(
        onPressed: () {
          print("You pressed: notificationbutton");
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
        child: const Icon(FontAwesomeIcons.bell, color: Color(0xFF65696F)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width - 85,
        color: Color(0xFF1A1D1F),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: searchBar(),
            ),
            Expanded(child: Container()),
            notificationButton(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  'lib/assets/graphics/placeholder.jfif',
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ));
  }
}
