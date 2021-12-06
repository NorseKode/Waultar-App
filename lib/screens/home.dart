import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/providers/theme_provider.dart';
import 'package:waultar/widgets/dashboard/dashboard.dart';
import 'package:waultar/widgets/general/menu_panel.dart';
import 'package:waultar/widgets/general/menu_panel2.dart';
import 'package:waultar/widgets/general/top_panel.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return getScaffoldMain(
        context,
        Row(
          children: [
            MenuPanel2(),
            SizedBox(width: 2),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: themeProvider.themeData().primaryColor,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width - 202,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TopPanel(),
                      Divider(
                        color:
                            themeProvider.themeData().scaffoldBackgroundColor,
                        indent: 35,
                        endIndent: 35,
                        height: 2,
                        thickness: 2,
                      ),
                      Container(
                        color: themeProvider.themeData().primaryColor,
                        height: 200,
                        width: MediaQuery.of(context).size.width - 202,
                      )
                    ]),
              ),
            )
          ],
        ));
  }
}
