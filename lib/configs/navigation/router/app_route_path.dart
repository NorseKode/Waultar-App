import 'package:waultar/configs/navigation/router/route_path.dart';
import 'package:waultar/configs/navigation/screen.dart';

class AppRoutePath extends RoutePath {
  // ignore: annotate_overrides, overridden_fields
  final ViewScreen viewScreen;
  
  AppRoutePath.home()        : viewScreen = ViewScreen.dashboard;
  AppRoutePath.dashboard()   : viewScreen = ViewScreen.dashboard;
  AppRoutePath.sigin()       : viewScreen = ViewScreen.signin;
  AppRoutePath.testScreen1() : viewScreen = ViewScreen.testScreen1;
  AppRoutePath.uploader()    : viewScreen = ViewScreen.uploader;
  AppRoutePath.settings()    : viewScreen = ViewScreen.settings;
  AppRoutePath.browse()      : viewScreen = ViewScreen.browse;
  AppRoutePath.timeline()    : viewScreen = ViewScreen.timeline;
  AppRoutePath.search()      : viewScreen = ViewScreen.search;
  AppRoutePath.unknown()     : viewScreen = ViewScreen.unknown;

  bool get isHomePage => viewScreen == ViewScreen.home;
  bool get isPage2    => viewScreen == ViewScreen.testScreen1;
  bool get isUploader => viewScreen == ViewScreen.uploader;
  bool get isUnknown  => viewScreen == ViewScreen.unknown;
}