import 'package:flutter/material.dart';

enum ServiceEnum { facebook, instagram, unknown }

extension ServiceMapper on ServiceEnum {
  static const colors = {
    ServiceEnum.facebook: Color(0xFF1778F2),
    ServiceEnum.instagram: Color(0xFFE1306C),
  };

  static const names = {
    ServiceEnum.facebook: 'Facebook',
    ServiceEnum.instagram: 'Instagram',
  };

  static const images = {
    ServiceEnum.facebook: "lib/assets/service_icons/facebook.svg",
    ServiceEnum.instagram: "lib/assets/service_icons/instagram.svg",
  };

  Color get color => colors[this] ?? Colors.grey;
  String get serviceName => names[this] ?? 'Unknown';
  String get image => images[this] ?? "";
}

ServiceEnum getFromID(int id) {
  switch (id) {
    case 1:
      return ServiceEnum.facebook;
    case 2:
      return ServiceEnum.instagram;
    default:
      return ServiceEnum.unknown;
  }
}
