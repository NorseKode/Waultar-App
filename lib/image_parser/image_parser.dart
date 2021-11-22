import 'dart:html';

import 'package:flutter/material.dart';

void imageCapture(List<File> fileList) {
  var imageList = fileList
      .map((item) => item.relativePath)
      .where((item) => item!.endsWith(".png"))
      .toList(growable: false);

  print(imageList.first.toString());
}
