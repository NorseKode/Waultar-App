import 'package:flutter/material.dart';

class MenuPanel extends StatefulWidget {
  const MenuPanel({Key? key}) : super(key: key);

  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  Widget logo() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Container(height: 50, width: 50, color: Colors.blue),
          SizedBox(
            width: 25,
          ),
          Text("Waultar", style: TextStyle(fontSize: 25))
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
          Icon(icon),
          const SizedBox(
            width: 30,
          ),
          Text(
            name,
            style: TextStyle(color: active ? Colors.white : Colors.grey),
          )
        ],
      ),
    );
  }

  Widget administrationMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.0),
        Text("Administration"),
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
      width: 300,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          logo(),
          administrationMenu(),
        ]),
      ),
    );
  }
}
