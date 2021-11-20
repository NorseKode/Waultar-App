import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/navigation/screen.dart';

class AppState with ChangeNotifier {
  ViewScreen viewScreen;
  Function? _updateNavigator;
  EtebaseUser? user;
  
  AppState(this.viewScreen, {this.user});

  // call this to set an object that updateState should call, otherwise leave it blank
  set updateNavigator(Function fun) => _updateNavigator = fun;
  
  void updateState(AppState appState) {
    viewScreen = appState.viewScreen;
    if (appState.user != null) {
      user = appState.user;
    }

    if (_updateNavigator != null) {
      _updateNavigator!();
    }
  }
}
