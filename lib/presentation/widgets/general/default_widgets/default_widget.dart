import 'package:flutter/material.dart';

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
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF272837)),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title),
                const SizedBox(height: 10),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color(0xFF4D4F68), width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: widget.child,
                    )),
              ],
            )));
  }
}
