// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waultar/navigation/app_navigator.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';

void main() async {
  await Hive.initFlutter();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
            create: (_) => AppState(ViewScreen.home)),
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
  void dispose()
  {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waultar',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
      // home: getAppNavigator(context.read<AppState>()),
      home: FutureBuilder(
          future: Hive.openBox<int>('testBox'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.error != null) {
                print(snapshot.error);
                return Scaffold(
                  body: Center(
                    child: Text('Something went wrong'),
                  ),
                );
              } else {
                return counterPage();
              }
            } else {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Loading ...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
          }),
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
