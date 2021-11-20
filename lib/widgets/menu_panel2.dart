import 'package:flutter/material.dart';

class MenuPanel2 extends StatefulWidget {
  const MenuPanel2({Key? key}) : super(key: key);

  @override
  _MenuPanel2State createState() => _MenuPanel2State();
}

enum MenuScreens {
  dashboard,
  datacollection,
  imagelibrary,
  settings,
  support,
  none
}

class _MenuPanel2State extends State<MenuPanel2> {
  var active = MenuScreens.dashboard;

  Widget menuItem(IconData icon, MenuScreens view) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextButton(
        onPressed: () {
          print("You pressed: " + view.toString());
        },
        style: active != view
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
        child: Icon(icon,
            color: active != view ? Color(0xFF65696F) : Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1A1D1F),
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
                  ),
                ),
              ),
              SizedBox(height: 10),
              menuItem(Icons.home, MenuScreens.dashboard),
              SizedBox(height: 10),
              menuItem(Icons.block, MenuScreens.datacollection),
              SizedBox(height: 10),
              menuItem(Icons.block, MenuScreens.imagelibrary),
              SizedBox(height: 10),
              menuItem(Icons.block, MenuScreens.support),
              SizedBox(height: 10),
              menuItem(Icons.block, MenuScreens.settings),
            ],
          ),
          Column(
            children: [
              Container(
                  width: 45,
                  child: Divider(
                      height: 5, thickness: 2, color: Color(0xFF65696F))),
              SizedBox(height: 10),
              menuItem(Icons.block, MenuScreens.none),
              SizedBox(height: 22.5),
            ],
          ),
        ],
      ),
    );
  }
}
