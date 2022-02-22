import 'package:flutter/material.dart';
import 'package:waultar/presentation/widgets/dashboard/widget_body.dart';

class DefaultWidget extends StatefulWidget {
  final String title;
  final Widget child;
  const DefaultWidget({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  _DefaultWidgetState createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<DefaultWidget> {
  @override
  Widget build(BuildContext context) {
    return WidgetBody(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        Divider(thickness: 2, height: 40, color: Color(0xFF4D4F68)),
        widget.child
      ],
    ));
  }
}
