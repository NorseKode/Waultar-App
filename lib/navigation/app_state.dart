import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'router/route_path.dart';

class AppState with ChangeNotifier {
  ValueChanged<RoutePath>? _updateNavigatorFun;
  
  AppState();
  
  set setNavigationFun(ValueChanged<RoutePath> fun) => _updateNavigatorFun = fun;
  
  updateNavigatorState(RoutePath routePath) {
    if (_updateNavigatorFun != null) {
      _updateNavigatorFun!(routePath);
    } else {
      throw FormatException('Unexpected null value', _updateNavigatorFun);
    }
  }
}
