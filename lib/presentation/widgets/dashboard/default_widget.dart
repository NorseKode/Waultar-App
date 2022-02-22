import 'package:flutter/material.dart';
import 'package:waultar/presentation/widgets/dashboard/widget_body.dart';

class DefaultWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry? edgeInsetsGeometry;
  const DefaultWidget({
    Key? key,
    required this.title,
    required this.child,
    this.edgeInsetsGeometry,
  }) : super(key: key);

  @override
  _DefaultWidgetState createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<DefaultWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.edgeInsetsGeometry ??
          const EdgeInsets.only(right: 20, bottom: 20),
      child: WidgetBody(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          Divider(thickness: 2, height: 40, color: Color(0xFF4D4F68)),
          widget.child
        ],
      )),
    );
  }
}
