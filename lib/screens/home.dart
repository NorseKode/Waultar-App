import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';

class HomePageView extends StatefulWidget {  
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            Text('This is the home page'),
            // _signOutButton(),
          ],
        ),
      ),
    );
  }
}
