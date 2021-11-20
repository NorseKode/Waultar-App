import 'package:flutter/material.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 105,
      color: Color(0xFF1A1D1F),
    );
  }
}
