import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:waultar/widgets/logo.dart';

class SignInView extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  SignInView(this._appState, this._updateAppState);

  @override
  _SignInViewState createState() =>
      _SignInViewState(_appState, _updateAppState);
}

class _SignInViewState extends State<SignInView> {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  _SignInViewState(this._appState, this._updateAppState);

  ElevatedButton _signUpButton() {
    return ElevatedButton(
      onPressed: () {
        _appState.viewScreen = ViewScreen.signup;
        _updateAppState(_appState);
      },
      child: const Text('Sign Up'),
    );
  }

  ElevatedButton _signInButtion() {
    return ElevatedButton(
      onPressed: () {
        _appState.user = 'something';
        _appState.viewScreen = ViewScreen.home;
        _updateAppState(_appState);
      },
      child: const Text('Sign In - go to home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    String pawIcon = 'lib/assets/graphics/Paw.svg';
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Row(
      mainAxisSize: MainAxisSize.max,
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
                              CustomPaint(
                                size: Size(
                                    40, (40 * 0.9016393442622951).toDouble()),
                                painter: PawPainter(Colors.blue),
                              ),
                              const SizedBox(width: 15),
                              const Text("Waultar",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ])),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: Text("Hi, welcome back!",
                                style: TextStyle(
                                    letterSpacing: 0.8,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)))
                      ]),
                  _signUpButton(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: []),
                  Row(children: [
                    const Text("Not a member? "),
                    Text("Sign up",
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
