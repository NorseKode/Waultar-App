import 'package:flutter/material.dart';

class MenuPanel1 extends StatefulWidget {
  const MenuPanel1({Key? key}) : super(key: key);

  @override
  _MenuPanel1State createState() => _MenuPanel1State();
}

class _MenuPanel1State extends State<MenuPanel1> {
  Widget logo() {
    return Container(
      child: Row(
        children: [
          Container(height: 30, width: 30, color: Colors.blue),
          SizedBox(
            width: 25,
          ),
          Text("Waultar", style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, String name, bool active) {
    return Container(
      decoration: BoxDecoration(
        color: active ? Colors.blue : null,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 50,
      child: Row(
        children: [
          Icon(
            icon,
            color: active ? Colors.white : Colors.grey,
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            name,
            style: TextStyle(
                color: active ? Colors.white : Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget administrationMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.0),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text("Administration"),
        ),
        SizedBox(height: 20),
        menuItem(Icons.access_alarm, "Overview", true),
        menuItem(Icons.access_alarm, "Data Collection", false),
        menuItem(Icons.access_alarm, "Image Library", false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: MediaQuery.of(context).size.height,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: logo(),
        ),
        administrationMenu(),
      ]),
    );
  }
}
