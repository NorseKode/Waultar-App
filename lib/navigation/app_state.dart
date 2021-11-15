import 'package:flutter/cupertino.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/navigation/screen.dart';

class AppState with ChangeNotifier {
  ViewScreen viewScreen;
  EtebaseUser? user;

  AppState(this.viewScreen, {this.user});

  void updateState(AppState appState) {
    viewScreen = appState.viewScreen;
    if (user != null) {
      user = appState.user;
    }
  }
}