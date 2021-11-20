import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';

class Page2 extends StatefulWidget {
  const Page2({ Key? key }) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context, 
      Center(
        child: Text('page2'),
      ),
    );
  }
}