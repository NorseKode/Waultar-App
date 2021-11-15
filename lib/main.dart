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
}

class WaultarApp extends StatefulWidget {
  @override
  _WaultarApp createState() => _WaultarApp();
}

class _WaultarApp extends State<WaultarApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waultar',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
      home: getAppNavigator(context.read<AppState>()),
    );
  }
}