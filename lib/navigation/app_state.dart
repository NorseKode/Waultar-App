import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waultar/etebase/models/etebase_user.dart';

import 'router/route_path.dart';

class AppState with ChangeNotifier {
  EtebaseUser? user;
  ValueChanged<RoutePath>? _updateNavigatorFun;
  
  AppState();
  
  set setNavigationFun(ValueChanged<RoutePath> fun) => _updateNavigatorFun = fun;
  
  updateUser(EtebaseUser etebaseUser, RoutePath routePath) {
    user = etebaseUser;
    updateNavigatorState(routePath);
  }

  updateNavigatorState(RoutePath routePath) {
    if (_updateNavigatorFun != null) {
      _updateNavigatorFun!(routePath);
    } else {
      throw FormatException('Unexpected null value', _updateNavigatorFun);
    }
  }
}
