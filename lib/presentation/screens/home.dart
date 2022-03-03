import 'package:flutter/material.dart';
import 'package:waultar/configs/globals/scaffold_main.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/widgets/browse/browse.dart';
import 'package:waultar/presentation/widgets/dashboard/dashboard.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';
import 'package:waultar/presentation/widgets/timeline/timeline.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final _screens = {
    ViewScreen.dashboard: const Dashboard(),
    ViewScreen.browse: const Browse(),
    ViewScreen.timeline: const Timeline(),
  };

  var _activeScreen = ViewScreen.dashboard;

  @override
  Widget build(BuildContext context) {
    void updateTabs(ViewScreen screen) {
      if (screen != _activeScreen) {
        setState(() {
          _activeScreen = screen;
        });
      }
    }

    return getScaffoldMain(
        context,
        Row(
          children: [
            MenuPanel(active: _activeScreen, updateActive: updateTabs),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TopPanel(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: _screens[_activeScreen],
                        ),
                      )
                    ]),
              ),
            )
          ],
        ));
  }
}
