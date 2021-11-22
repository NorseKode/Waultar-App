// import 'dart:js';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/router/app_route_path.dart';

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
  /*FutureBuilder loadApplication(BuildContext context) 
  {
    return FutureBuilder(
      future: Hive.openBox<Settings>('settings'), 
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
        {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Loading ...'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        else 
        {
          if (snapshot.error != null)
          {
            print(snapshot.error);
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            );
          }
          else 
          {
            var _settingsBox = Hive.box<Settings>('settings');

            // if the settings box is empty, the app is run for the first time at the client
            // thus, we will seed settings with some default settings
            var firstTimeUser = _settingsBox.isEmpty;
            if (firstTimeUser)
            {
              print('first time user');
              Settings defaultSettings = Settings();
              _settingsBox.add(defaultSettings);
              // proceed to load the application with default settings
            }
            else 
            {
              print('not first time user');
              // it is not the first time opening the app, and settings are configured
              // proceed to load the application and get the actual settings with this command :
              // var content = _settingsBox.get('settings');
              var content = _settingsBox.get(0);
              print(content?.key);
            }
            
            return const CounterPage();
          }
        }
      } 
    );
  }*/

  @override
  void dispose()
  {
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

  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Waultar',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
      // home: getAppNavigator(context.read<AppState>()),
      // home: loadApplication(context)
      routerDelegate: _routerDelegate!,
      routeInformationParser: _routeInformationParser,
    );
  }
}
