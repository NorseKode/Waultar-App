import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ServiceModel {
  int id;
  String name;
  String company;
  Uri image;
  late IconData? icon;
  late Color? color;

  ServiceModel(
      {this.id = 0,
      required this.name,
      required this.company,
      required this.image}) {
    if (name == "Facebook") {
      color = const Color(0xFF1877F2);
      icon = Iconsax.message_question;
    } else if (name == "Instagram") {
      color = const Color(0xFFD82F7F);
      icon = Iconsax.message_question;
    } else {
      color = const Color(0x00000000);
      icon = Iconsax.message_question;
    }
  }
}
