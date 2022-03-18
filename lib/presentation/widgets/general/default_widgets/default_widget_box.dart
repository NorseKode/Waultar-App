import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class DefaultWidgetBox extends StatefulWidget {
  Widget child;
  DefaultWidgetBox({Key? key, required this.child}) : super(key: key);

  @override
  State<DefaultWidgetBox> createState() => _DefaultWidgetBoxState();
}

class _DefaultWidgetBoxState extends State<DefaultWidgetBox> {
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeProvider.themeData().primaryColor),
        child: Padding(padding: const EdgeInsets.all(20), child: widget.child));
  }
}
