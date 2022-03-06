import 'package:flutter/material.dart';
import 'package:waultar/configs/navigation/no_animation_delegate.dart';
import 'package:waultar/configs/navigation/router/route_path.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/screens/authentication/signin.dart';
import 'package:waultar/presentation/screens/browse_view.dart';
import 'package:waultar/presentation/screens/dashboard_view.dart';
import 'package:waultar/presentation/screens/search_view.dart';
import 'package:waultar/presentation/screens/settings_view.dart';
import 'package:waultar/presentation/screens/timeline_view.dart';
import 'package:waultar/presentation/screens/unknown_view.dart';

import 'app_state.dart';

Navigator getAppNavigator(
    AppState appState, RoutePath routePath, ValueChanged<RoutePath> _updateState) {
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
          child: DashboardView(),
        ),
      if (routePath.viewScreen == ViewScreen.dashboard)
        const MaterialPage(
          key: ValueKey('Dashboard'),
          child: DashboardView(),
        ),
      if (routePath.viewScreen == ViewScreen.settings)
        const MaterialPage(
          key: ValueKey('Settings'),
          child: SettingsView(),
        ),
      if (routePath.viewScreen == ViewScreen.browse)
        const MaterialPage(
          key: ValueKey("Browse"),
          child: BrowseView(),
        ),
      if (routePath.viewScreen == ViewScreen.search)
        const MaterialPage(
          key: ValueKey("Search"),
          child: SearchView(),
        ),
      if (routePath.viewScreen == ViewScreen.timeline)
        const MaterialPage(
          key: ValueKey("Timeline"),
          child: TimelineView(),
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
