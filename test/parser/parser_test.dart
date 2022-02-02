import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/image_model.dart';
import 'package:waultar/core/parsers/naive_parser.dart';

main() {
  var pathToCurrentFile = path_dart
      .normalize(path_dart.join(path_dart.dirname(Platform.script.path), "test", "parser"))
      .substring(1);

  var emptyObject = File(path_dart.join(pathToCurrentFile, "data", "empty_object.json"));
  var emptyList = File(path_dart.join(pathToCurrentFile, "data", "empty_list.json"));
  var corrupted = File(path_dart.join(pathToCurrentFile, "data", "corrupt.json"));
  var mediaJson1 = File(path_dart.join(pathToCurrentFile, "data", "each_media_type_list.json"));

  group("Initial testing of edge cases with: ", () {
    test("empty json object", () async {
      var result = await NaiveParser.parseFile(emptyObject);

      var images = result["Images"] as List<ImageModel>;

      expect(images.isEmpty, true);
    });

    test("empty json list", () async {
      var result = await NaiveParser.parseFile(emptyList);

      var images = result["Images"] as List<ImageModel>;

      expect(images.isEmpty, true);
    });

    test("corrupted json", () async {
      expect(() async => await NaiveParser.parseFile(corrupted), throwsException);
    });
  });

  // group("Tests of json containing media. ", () {
  //   test("Json containing one of each media", () async {
  //     var result = await NaiveParser.parseFile(mediaJson1);

  //     var images = result["Images"] as List<ImageModel>;

  //     expect(images.length, 2);
  //   });
  // });
}
