import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/parsers/instagram_parser.dart';

import '../test_helper.dart';

main() {
  var instagramMedia = File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "instagram_media.json"));

  group("Testig parsing of media data: ", () {
    group("Instagram, ", () {
      test("mixed media data, parse images", () async {
        var parser = InstragramParser();

        var res = await parser.parseFile(instagramMedia).toList();

        expect(res.isNotEmpty, true);
      });
    });
  });
}
