import 'package:flutter/material.dart';

abstract class UIModel {
  DateTime? getTimestamp();

  String getMostInformativeField();

  Color getAssociatedColor();

  Map<String, dynamic> toMap();
}