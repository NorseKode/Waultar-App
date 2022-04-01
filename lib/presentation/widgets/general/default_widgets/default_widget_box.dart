import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

// ignore: must_be_immutable
class DefaultWidgetBox extends StatefulWidget {
  Widget child;
  final BoxConstraints? constraints;
  final double? padding;
  DefaultWidgetBox(
      {Key? key, required this.child, this.constraints, this.padding})
      : super(key: key);

  @override
  State<DefaultWidgetBox> createState() => _DefaultWidgetBoxState();
}

class _DefaultWidgetBoxState extends State<DefaultWidgetBox> {
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        constraints: widget.constraints ?? const BoxConstraints(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeProvider.themeData().primaryColor),
        child: Padding(
            padding: EdgeInsets.all(widget.padding ?? 20),
            child: widget.child));
  }
}
