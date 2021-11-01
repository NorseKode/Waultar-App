import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/navigation/screen.dart';

class AppState {
  ViewScreen viewScreen;
  EtebaseUser? user;

  AppState(this.viewScreen, {this.user});
}