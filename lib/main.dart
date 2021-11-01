import 'package:flutter/material.dart';
import 'package:waultar/navigation/app_navigator.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';

void main() {
  AppState _appState = AppState(ViewScreen.signin);

  runApp(WaultarApp(_appState));
}

class WaultarApp extends StatefulWidget {
  final AppState _appState;

  WaultarApp(this._appState);

  @override
  _WaultarApp createState() => _WaultarApp(_appState);
}

class _WaultarApp extends State<WaultarApp> {
  AppState _appState;

  _WaultarApp(this._appState);

  void _updateAppState(AppState? appState) {
    setState(() {
      if (appState != null) _appState = appState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'SF-Pro'),
      home: getAppNavigator(_appState, _updateAppState),
    );
  }
}

// class WaultarApp extends StatelessWidget {
//   final AppState _appState;

//   const WaultarApp(this._appState, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.grey,
//       ),
//       home: const SignUp(),
//     );
//   }
// }
