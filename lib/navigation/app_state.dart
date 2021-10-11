import 'package:waultar/navigation/screen.dart';

class AppState {
  ViewScreen viewScreen;
  String? user; // TODO: change to etebase auth token

  AppState(this.viewScreen, {this.user});
}