import 'package:flutter/material.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/screens/shared/waultar_desktop_main.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';
import 'package:waultar/presentation/widgets/timeline/timeline.dart';

class TimelineView extends StatefulWidget {
  const TimelineView({Key? key}) : super(key: key);

  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  final _activeScreen = ViewScreen.timeline;

  _callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return getWaultarDesktopMainBody(
      context,
      MenuPanel(
        active: _activeScreen,
        callback: () {
          _callback();
        },
      ),
      const TopPanel(),
      const Timeline(),
    );
  }
}
