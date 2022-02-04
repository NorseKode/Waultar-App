import 'package:flutter/material.dart';
import 'package:waultar/configs/navigation/no_animation_delegate.dart';
import 'package:waultar/configs/navigation/router/route_path.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/screens/authentication/signin.dart';
import 'package:waultar/presentation/screens/home.dart';
import 'package:waultar/presentation/screens/unknown.dart';
import 'package:waultar/presentation/widgets/upload/uploader.dart';

import 'app_state.dart';

Navigator getAppNavigator(AppState appState, RoutePath routePath, ValueChanged<RoutePath> _updateState) {
  return Navigator(
    transitionDelegate: NoAnimationTransitionDelegate(),
    pages: [
      if (routePath.viewScreen == ViewScreen.unknown)
        const MaterialPage(
          key: ValueKey('Unknown'),
          child: UnknownView(),
        ),
      if (routePath.viewScreen == ViewScreen.home)
        const MaterialPage(
          key: ValueKey('HomePage'),
          child: HomePageView(),
        ),
      // if (routePath.viewScreen == ViewScreen.uploader)
      //   const MaterialPage(
      //     key: ValueKey('Uploader'),
      //     child: UploaderComponent(),
      //   ),
      if (routePath.viewScreen == ViewScreen.signin && appState.user == null)
        const MaterialPage(
          key: ValueKey('SignIn'),
          child: SignInView(),
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
