import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/models/tables/images_table.dart';
import 'package:waultar/parser/naive_parser.dart';
import 'package:path/path.dart' as path_dart;

void main() {
  var emptyObject = path_dart.join("data", "empty_object.json");
  var emptyList = path_dart.join("data", "empty_list.json");

  group("fodspkfpsdko", () {
    test('Parser given empty json object', () {
      var result = NaiveParser.parseFile(File(emptyObject));

      var images = result["Images"] as List<Image>;

      expect(images.isEmpty, true);
    });

    test('Parser given empty json list', () {
      var result = NaiveParser.parseFile(File(emptyList));

      var images = result["Images"] as List<Image>;

      expect(images.isEmpty, true);
    });
  });
}
