import 'package:flutter/material.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/screens/authentication/signin.dart';
import 'package:waultar/screens/authentication/signup.dart';
import 'package:waultar/screens/home.dart';

Navigator getAppNavigator(AppState appState, ValueChanged<AppState> updateAppState) {
  return Navigator(
    pages: [
      if (appState.user != null)
        MaterialPage(
          key: ValueKey('HomePage'),
          child: HomePageView(appState, updateAppState),
        ),
      if (appState.user == null && appState.viewScreen == ViewScreen.signin)
        MaterialPage(
          key: ValueKey('SignInView'),
          child: SignInView(appState, updateAppState),
        ),
      if (appState.user == null && appState.viewScreen == ViewScreen.signup)
        MaterialPage(
          key: ValueKey('SignUpView'),
          child: SignUp(appState, updateAppState),
        ),
    ],
    onPopPage: (route, result) {
      if (!route.didPop(result)) return false;

      if (route.isFirst) {
        appState.user = null;
        // updateState();
      }

      return true;
    },
  );
}
