import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:waultar/configs/navigation/app_state.dart';
import 'package:waultar/configs/navigation/router/app_route_information_parser.dart';
import 'package:waultar/configs/navigation/router/app_route_path.dart';
import 'package:waultar/configs/navigation/router/app_router_delegate.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/ai/image_classifier_mobilenetv3.dart';
import 'package:waultar/domain/services/ml_service.dart';
import 'package:waultar/domain/services/sentiment_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

import 'configs/globals/app_logger.dart';
import 'startup.dart';

void main() async {
  await setupServices();

  locator.registerSingleton<IMLService>(
    MLService(),
    instanceName: 'mlService',
  );
  locator.registerSingleton<ISentimentService>(
    SentimentService(),
    instanceName: 'sentimentService',
  );

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
    if (kDebugMode) {
      File(locator.get<String>(instanceName: 'log_folder') + "/logs.txt")
          .writeAsString("");
    }

    if (kIsWeb) {
      _routerDelegate = AppRouterDelegate(AppRoutePath.sigin());
    } else {
      _routerDelegate = AppRouterDelegate(AppRoutePath.home());
    }

    if (!kDebugMode) {
      locator.get<BaseLogger>(instanceName: 'logger').setLogLevelRelease();
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
