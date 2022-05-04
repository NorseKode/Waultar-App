import 'package:flutter/material.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/screens/shared/waultar_desktop_main.dart';
import 'package:waultar/presentation/widgets/dashboard/dashboard.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _activeScreen = ViewScreen.dashboard;
  callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return getWaultarDesktopMainBody(
        context,
        MenuPanel(active: _activeScreen, callback: callback),
        const TopPanel(),
        const Dashboard());
  }
}
