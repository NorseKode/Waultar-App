import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:waultar/configs/navigation/app_state.dart';
import 'package:waultar/configs/navigation/router/app_route_information_parser.dart';
import 'package:waultar/configs/navigation/router/app_route_path.dart';
import 'package:waultar/configs/navigation/router/app_router_delegate.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

import 'startup.dart';

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
    super.dispose();
  }

  AppRouterDelegate? _routerDelegate;

  @override
  void initState() {
    if (kIsWeb) {
      _routerDelegate = AppRouterDelegate(AppRoutePath.sigin());
    } else {
      _routerDelegate = AppRouterDelegate(AppRoutePath.home());
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
      // locale: Locale('da', ''),
      theme: themeProvider.themeData(),
      routerDelegate: _routerDelegate!,
      routeInformationParser: _routeInformationParser,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('da', ''),
      ],
    );
  }
}
