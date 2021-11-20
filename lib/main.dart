import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/navigation/app_navigator.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState(ViewScreen.home)),
      ],
      child: WaultarApp(),
    ),
  );
  // runApp(WaultarApp());
}

class WaultarApp extends StatefulWidget {
  @override
  _WaultarApp createState() => _WaultarApp();
}

class _WaultarApp extends State<WaultarApp> {
  AppRouterDelegate _routerDelegate = AppRouterDelegate();
  AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
  // _updateMainState() {
  //   setState(() {});
  // }
  // AppState _appState = AppState(ViewScreen.home, _updateMainState);

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<AppState>(create: (_) => _appState),
    //   ],
    //   child:
    // return MaterialApp(
    //   title: 'Waultar',
    //   theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
    //   // home: context.watch<AppState>(),
    //   home: getAppNavigator(context.read<AppState>()),
    // );
    // );
    return MaterialApp.router(
      title: 'Waultar',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
      // home: context.watch<AppState>(),
      // home: getAppNavigator(context.read<AppState>()),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class AppRoutePath {
  AppRoutePath.home();
  AppRoutePath.page2();
  AppRoutePath.unknown();
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath> with ChangeNotifier {
  // TODO: app state here
  _updateState() {
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.read<AppState>();
    appState.updateNavigator = _updateState;
    return getAppNavigator(appState, _updateState);
  }


  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    throw UnimplementedError();
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    // TODO: implement setNewRoutePath
    // throw UnimplementedError();
  }
}

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    if (routeInformation.location != null) {
      final uri = Uri.parse(routeInformation.location!);

      // root: /
      if (uri.pathSegments.length == 0) {
        return AppRoutePath.home();
      }

      if (uri.pathSegments.length == 1) {
        if (uri.pathSegments[0] != 'page2')
          return AppRoutePath.unknown();
        
        return AppRoutePath.page2();
      }
    }

    return AppRoutePath.unknown();
  }
}
