import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';

class DefaultWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final String? description;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final Color? color;
  const DefaultWidget({
    Key? key,
    required this.title,
    required this.child,
    this.description,
    this.padding,
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
        padding: widget.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: themeProvider.themeData().textTheme.headline1),

            if (widget.description != null)
              Column(
                children: [
                  const SizedBox(height: 2),
                  Text(
                    widget.description!,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 149, 150, 159),
                        fontFamily: "Poppins",
                        fontSize: 11,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            widget.child
            // Container(
            //     // decoration: BoxDecoration(
            //     //     border: Border(
            //     //   top: BorderSide(
            //     //       color: themeProvider.themeMode().tonedColor, width: 2),
            //     // )),
            //     child: Padding(
            //   padding: const EdgeInsets.only(top: 10),
            //   child: widget.child,
            // )),
          ],
        ));
  }
}
