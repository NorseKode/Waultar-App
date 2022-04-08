import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';

class DefaultWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry? edgeInsetsGeometry;
  final BoxConstraints? constraints;
  final Color? color;
  const DefaultWidget({
    Key? key,
    required this.title,
    required this.child,
    this.edgeInsetsGeometry,
    this.constraints,
    this.color,
  }) : super(key: key);

  @override
  _DefaultWidgetState createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<DefaultWidget> {
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultWidgetBox(
        color: widget.color,
        constraints: widget.constraints,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: themeProvider.themeData().textTheme.headline1),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                      color: themeProvider.themeMode().tonedColor, width: 2),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: widget.child,
                )),
          ],
        ));
  }
}
