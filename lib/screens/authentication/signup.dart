import 'package:flutter/material.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/widgets/darkmode.dart';

class SignUp extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  SignUp(this._appState, this._updateAppState);

  @override
  _SignUpState createState() => _SignUpState(_appState, _updateAppState);
}

class _SignUpState extends State<SignUp> {
  AppState _appState;
  ValueChanged<AppState> _updateAppState;

  _SignUpState(this._appState, this._updateAppState);

  _signInElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        _appState = AppState(ViewScreen.signin);
        _updateAppState(_appState);
      },
      child: const Text('Sign In'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('This is the sign up page'),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            DarkModeSwitch(),
          ]),
          _signInElevatedButton(),
        ]),
      ),
    );
  }
}

// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: <Widget>[
//     Row(),
//     const Text(
//       'Waultar',
//     ),
//     Row(
//       children: [
//         Column(
//           children: [
//             Text("Control your data your way"),
//             Row(),
//             Row(),
//             Row(),
//             Row(),
//           ],
//         ),
//         Container()
//       ],
//     )
//   ],
// ),
