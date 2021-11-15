import 'package:flutter/material.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/no_animation_delegate.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/screens/home.dart';

Navigator getAppNavigator(
    AppState appState) {
  return Navigator(
    transitionDelegate: NoAnimationTransitionDelegate(),
    pages: [
      if (appState.viewScreen == ViewScreen.home)
        MaterialPage(
          key: ValueKey('HomePage'),
          child: HomePageView(),
        ),
    ],
    onPopPage: (route, result) {
      if (!route.didPop(result)) return false;

      if (route.isFirst) {
        appState.user = null;
      }

      return true;
    },
  );
}
