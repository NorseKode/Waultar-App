import 'package:flutter/material.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/screens/shared/waultar_desktop_main.dart';
import 'package:waultar/presentation/widgets/browse/browse.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';

class BrowseView extends StatefulWidget {
  const BrowseView({Key? key}) : super(key: key);

  @override
  _BrowseViewState createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView> {
  final _activeScreen = ViewScreen.browse;

  @override
  Widget build(BuildContext context) {
    return getWaultarDesktopMainBody(
      context,
      MenuPanel(active: _activeScreen),
      const TopPanel(),
      const Browse(),
    );
  }
}
