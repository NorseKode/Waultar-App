import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/router/app_route_path.dart';

import 'navigation/router/app_route_information_parser.dart';
import 'navigation/router/app_router_delegate.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ],
      child: const WaultarApp(),
    ),
  );
  // runApp(WaultarApp());
}

class WaultarApp extends StatefulWidget {
  const WaultarApp({Key? key}) : super(key: key);

  @override
  _WaultarApp createState() => _WaultarApp();
}

class _WaultarApp extends State<WaultarApp> {
  final AppRouterDelegate _routerDelegate = AppRouterDelegate(AppRoutePath.uploader());
  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Waultar',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}