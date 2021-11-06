import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';

class Dashboard extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  Dashboard(this._appState, this._updateAppState);

  @override
  _DashboardState createState() => _DashboardState(_appState, _updateAppState);
}

class _DashboardState extends State<Dashboard> {
  AppState _appState;
  ValueChanged<AppState> _updateAppState;

  _DashboardState(this._appState, this._updateAppState);

  ElevatedButton _signOutButton() {
    return ElevatedButton(
        onPressed: () {
          _appState.user = null;
          _appState.viewScreen = ViewScreen.signin;
          _updateAppState(_appState);
        },
        child: const Text('Sign out'));
  }

  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            Text('This is the dashboard page'),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
