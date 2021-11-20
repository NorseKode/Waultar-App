import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/router/app_route_path.dart';
import 'package:waultar/navigation/router/route_path.dart';

class HomePageView extends StatefulWidget {  
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  _navTest(BuildContext context) {
    return ElevatedButton(onPressed: () {
      context.read<AppState>().updateNavigatorState(AppRoutePath.page2());
    } , child: Text('test'));
  }
  
  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            Text('This is the home page'),
            _navTest(context),
            // _signOutButton(),
          ],
        ),
      ),
    );
  }
}
