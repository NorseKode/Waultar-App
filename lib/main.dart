// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/navigation/app_navigator.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';

import 'models/settings.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());

  await Hive.openBox<int>('testBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
            create: (_) => AppState(ViewScreen.home)),
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

  FutureBuilder loadApplication(BuildContext context) 
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
              Settings default_settings = Settings();
              _settingsBox.add(default_settings);
              // proceed to load the application with default settings
            }
            else 
            {
              // it is not the first time opening the app, and settings are configured
              // proceed to load the application and get the actual settings with this command :
              var content = _settingsBox.values.first;
            }

            return const counterPage();
          }
        }
      } 
    );
  }

  @override
  void dispose()
  {
    // closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waultar',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
      // home: getAppNavigator(context.read<AppState>()),
      home: loadApplication(context)
    );
  }
}

class counterPage extends StatefulWidget {
  const counterPage({Key? key}) : super(key: key);

  @override
  _counterPageState createState() => _counterPageState();
}

class _counterPageState extends State<counterPage> {
  late Box<int> _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box<int>('testBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter test with Hive'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Restart the app to test persistance with Hive'),
            SizedBox(
              height: 8,
            ),
            Text('You have invoked the counter this many times:'),
            ValueListenableBuilder<Box<int>>(
              valueListenable: _box.listenable(),
              builder: (context, box, _) {
                return Text(
                  '${box.get('counter', defaultValue: 0)}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            IconButton(
                onPressed: () 
                {
                  _box.put('counter', _box.get('counter', defaultValue: 0)! + 1);
                },
                icon: Icon(Icons.plus_one)),
          ],
        ),
      ),
    );
  }
}
