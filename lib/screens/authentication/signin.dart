import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';

class SignInView extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  SignInView(this._appState, this._updateAppState);

  @override
  _SignInViewState createState() => _SignInViewState(_appState, _updateAppState);
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
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            Text('This is the Sign In Page'),
            _signUpButton(),
            _signInButtion(),
          ],
        ),
      ),
    );
  }
}
