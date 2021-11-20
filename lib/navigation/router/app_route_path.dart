import 'package:waultar/navigation/router/route_path.dart';
import 'package:waultar/navigation/screen.dart';

class AppRoutePath extends RoutePath {
  ViewScreen viewScreen;
  
  AppRoutePath.home() : viewScreen = ViewScreen.home;
  AppRoutePath.testScreen1() : viewScreen = ViewScreen.testScreen1;
  AppRoutePath.unknown() : viewScreen = ViewScreen.unknown;

  bool get isHomePage => viewScreen == ViewScreen.home;
  bool get isPage2    => viewScreen == ViewScreen.testScreen1;
  bool get isUnknown  => viewScreen == ViewScreen.unknown;
}