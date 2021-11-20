import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';

class HomePageView extends StatefulWidget {  
  final Function _updateState;

  HomePageView(this._updateState);
  
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  _navTest(BuildContext context) {
    return ElevatedButton(onPressed: () {
      var appState = context.read<AppState>();
      appState.viewScreen = ViewScreen.page2;
      appState.updateState(appState);
      // widget._updateState();
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
