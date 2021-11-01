import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/navigation/screen.dart';

class AppState {
  ViewScreen viewScreen;
  String? user; // TODO: change to etebase auth token
  EtebaseUser? user2; // TODO: change to etebase auth token

  AppState(this.viewScreen, {this.user, this.user2});
}