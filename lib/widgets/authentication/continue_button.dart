import 'package:flutter/material.dart';

class ContinueButton extends StatefulWidget {
  final String _text;
  ContinueButton(this._text);

  @override
  _ContinueButtonState createState() => _ContinueButtonState(_text);
}

class _ContinueButtonState extends State<ContinueButton> {
  String _text;
  _ContinueButtonState(this._text);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
