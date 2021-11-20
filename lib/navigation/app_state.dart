import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'router/route_path.dart';

class AppState with ChangeNotifier {
  ValueChanged<RoutePath>? updateNavigatorFun;
  
  AppState();
  
  updateNavigatorState(RoutePath routePath) {
    if (updateNavigatorFun != null) {
      updateNavigatorFun!(routePath);
    } else {
      throw FormatException('Unexpected null value', updateNavigatorFun);
    }
  }
}
