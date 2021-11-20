import 'package:flutter/material.dart';
import 'package:waultar/navigation/no_animation_delegate.dart';
import 'package:waultar/navigation/router/route_path.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/screens/home.dart';
import 'package:waultar/screens/temp/test1.dart';
import 'package:waultar/screens/unknown.dart';


Navigator getAppNavigator(RoutePath routePath, ValueChanged<RoutePath> _updateState) {
  return Navigator(
    transitionDelegate: NoAnimationTransitionDelegate(),
    pages: [
      if (routePath.viewScreen == ViewScreen.testScreen1)
        const MaterialPage(
          key: ValueKey('TestScreen'),
          child: TestView1(),
        ),
      if (routePath.viewScreen == ViewScreen.unknown)
        const MaterialPage(
          key: ValueKey('Unknown'),
          child: UnknownView(),
        ),
      if (routePath.viewScreen == ViewScreen.home)
        MaterialPage(
          key: ValueKey('HomePage'),
          child: HomePageView(),
        ),
    ],
    onPopPage: (route, result) {
      if (!route.didPop(result)) return false;

      if (route.isFirst) {
        // appState.user = null;
      }

      return true;
    },
  );
}
