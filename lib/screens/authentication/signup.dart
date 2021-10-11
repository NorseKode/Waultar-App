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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04, vertical: width * .04),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Text('Already using? '),
              _signInElevatedButton(),
              Padding(padding: EdgeInsets.only(left: width * .01), child: DarkModeSwitch()),
            ])),
        Text('This is the sign up page'),
        _signInElevatedButton(),
      ]),
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
