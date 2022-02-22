import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width - 250,
      color: themeProvider.themeData().primaryColor,
      //child: Text("toppanel") //TODO:toppanel
    );
  }
}
