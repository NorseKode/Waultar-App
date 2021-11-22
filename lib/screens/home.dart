import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/widgets/dashboard/dashboard.dart';
import 'package:waultar/widgets/general/menu_panel.dart';
import 'package:waultar/widgets/general/top_panel.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(title, style: Theme.of(context).textTheme.headline1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
        context,
        Row(
          children: [
            MenuPanel(),
            SizedBox(width: 5),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [TopPanel(), title("Dashboard"), Dashboard()]),
            )
          ],
        ));
  }
}
