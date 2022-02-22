import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/scaffold_main.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/dashboard/dashboard.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

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
            const MenuPanel(),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TopPanel(),
                      Expanded(
                        child: Container(
                          child:
                              const Dashboard(), //TODO: Navigation: Screen to change across views.
                        ),
                      )
                    ]),
              ),
            )
          ],
        ));
  }
}
