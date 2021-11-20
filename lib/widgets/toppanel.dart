import 'package:flutter/material.dart';

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
            Container(
              width: 30,
              height: 30,
              color: Colors.grey,
            ),
            SizedBox(width: 20),
            Container(
              width: 30,
              height: 30,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.blue,
              ),
            )
          ],
        ));
  }
}
