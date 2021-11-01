import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/widgets/darkmode.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:waultar/widgets/signup_form.dart';
import 'package:js/js.dart';

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

  final dataGraphic = const Image(
      color: Color.fromARGB(255, 25, 118, 210),
      image: AssetImage('lib/assets/graphics/data_graphic.png'));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(100.0, 50.0, 100.0, 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Row(children: [
                              Icon(
                                Iconic.chart_pie,
                                size: 18,
                                color: Colors.blueAccent[700],
                              ),
                              const SizedBox(width: 15),
                              const Text("Waultar",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ])),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: Text("Hi, welcome to Waultar!",
                                style: TextStyle(
                                    letterSpacing: 0.8,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)))
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [SignUpForm(_appState, _updateAppState)]),
                  Row(children: [
                    const Text("Are you already a member? "),
                    Text("Sign in",
                        style: TextStyle(color: Colors.blueAccent[700]))
                  ]),
                ],
              )),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blueAccent[700],
          ),
        ) //child: dataGraphic),
      ],
    ));
  }
}

// Column(children: [
//         Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: width * .04, vertical: width * .04),
//             child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//               const Text('Already using? '),
//               _signInElevatedButton(),
//               // Padding(padding: EdgeInsets.only(left: width * .01), child: DarkModeSwitch()),
//             ])),
//         Text('This is the sign up page'),
//         _signInElevatedButton(),
//       ])

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
