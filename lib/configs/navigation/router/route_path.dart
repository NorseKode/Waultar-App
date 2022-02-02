import 'package:waultar/configs/navigation/screen.dart';

abstract class RoutePath {
  final ViewScreen viewScreen;

  RoutePath() : viewScreen = ViewScreen.unknown;

  RoutePath.viewScreen(this.viewScreen);
}