import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import '../app_navigator.dart';
import '../app_state.dart';
import 'app_route_path.dart';
import 'route_path.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath> with ChangeNotifier {
  RoutePath _routePath;

  AppRouterDelegate(this._routePath);

  _updateNavigationState(RoutePath newRoutePath) {
    _routePath = newRoutePath;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {  
    context.read<AppState>().setNavigationFun = _updateNavigationState;
    return getAppNavigator(context.read<AppState>(), _routePath, _updateNavigationState);
  }

  @override
  Future<bool> popRoute() {
    throw UnimplementedError('Back button function not implemented');
  }

  // Allows update of state when a route is changed
  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isHomePage) {
      return;
    }

    if (configuration.isPage2) {
      return;
    }

    if (configuration.isUnknown) {
      return;
    }
  }
}