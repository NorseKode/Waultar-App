import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/providers/theme_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Expanded(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: themeProvider.themeData().primaryColor,
              width: MediaQuery.of(context).size.width - 82,
              height: 2000),
        ],
      )),
    );
  }
}
