import 'package:flutter/material.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/screens/shared/waultar_desktop_main.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';
import 'package:waultar/presentation/widgets/search/search.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _activeScreen = ViewScreen.search;
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
      const Search(),
    );
  }
}
