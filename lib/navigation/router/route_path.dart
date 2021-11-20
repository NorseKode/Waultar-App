import 'package:waultar/navigation/screen.dart';

abstract class RoutePath {
  ViewScreen viewScreen;

  RoutePath() : viewScreen = ViewScreen.unknown;

  RoutePath.viewScreen(this.viewScreen);
}