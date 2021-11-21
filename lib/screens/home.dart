import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/widgets/dashboard.dart';
import 'package:waultar/widgets/general/menu_screens.dart';
import 'package:waultar/widgets/general/menu_panel.dart';
import 'package:waultar/widgets/general/top_panel.dart';

class HomePageView extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  HomePageView(this._appState, this._updateAppState);

  @override
  _HomePageViewState createState() =>
      _HomePageViewState(_appState, _updateAppState);
}

class _HomePageViewState extends State<HomePageView> {
  AppState _appState;
  ValueChanged<AppState> _updateAppState;

  _HomePageViewState(this._appState, this._updateAppState);

  ElevatedButton _signOutButton() {
    return ElevatedButton(
        onPressed: () {
          _appState.user = null;
          _appState.viewScreen = ViewScreen.signin;
          _updateAppState(_appState);
        },
        child: const Text('Sign out'));
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
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
