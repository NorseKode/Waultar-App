import 'package:waultar/navigation/router/route_path.dart';
import 'package:waultar/navigation/screen.dart';

class AppRoutePath extends RoutePath {
  ViewScreen viewScreen;
  
  AppRoutePath.home() : viewScreen = ViewScreen.home;
  AppRoutePath.page2() : viewScreen = ViewScreen.page2;
  AppRoutePath.unknown() : viewScreen = ViewScreen.unknown;

  bool get isHomePage => viewScreen == ViewScreen.home;
  bool get isPage2    => viewScreen == ViewScreen.page2;
  bool get isUnknown  => viewScreen == ViewScreen.unknown;
}