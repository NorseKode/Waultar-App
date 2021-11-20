import 'package:flutter/material.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/no_animation_delegate.dart';
import 'package:waultar/navigation/router/route_path.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/screens/home.dart';
import 'package:waultar/screens/page2.dart';

import 'router/app_route_path.dart';

Navigator getAppNavigator(RoutePath routePath, ValueChanged<RoutePath> _updateState) {
  return Navigator(
    transitionDelegate: NoAnimationTransitionDelegate(),
    pages: [
      if (routePath.viewScreen == ViewScreen.home)
        MaterialPage(
          key: ValueKey('HomePage'),
          child: HomePageView(),
        ),
      if (routePath.viewScreen == ViewScreen.page2)
        const MaterialPage(
          key: ValueKey('Page2'),
          child: Page2(),
        )
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
