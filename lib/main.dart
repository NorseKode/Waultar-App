// import 'dart:js';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/navigation/app_navigator.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/router/app_route_path.dart';
import 'package:waultar/providers/theme_provider.dart';

import 'navigation/router/app_route_information_parser.dart';
import 'navigation/router/app_router_delegate.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'services/startup.dart';

void main() async {
  await setupServices();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => ThemeProvider())
      ],
      child: const WaultarApp(),
    ),
  );
}

class WaultarApp extends StatefulWidget {
  const WaultarApp({Key? key}) : super(key: key);

  @override
  _WaultarApp createState() => _WaultarApp();
}

class _WaultarApp extends State<WaultarApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  AppRouterDelegate? _routerDelegate;

  @override
  void initState() {
    if (kIsWeb) {
      _routerDelegate = AppRouterDelegate(AppRoutePath.sigin());
    } else {
      _routerDelegate = AppRouterDelegate(AppRoutePath.testScreen1());
    }
    super.initState();
  }

  final AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      title: 'Waultar',
      theme: themeProvider.themeData(),
      //theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
      // theme: ThemeData(
      //     primarySwatch: Colors.grey,
      //     scaffoldBackgroundColor: Color(0xFF111315),
      //     fontFamily: 'Inter'),
      routerDelegate: _routerDelegate!,
      routeInformationParser: _routeInformationParser,
    );
  }
}
