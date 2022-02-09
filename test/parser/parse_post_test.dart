import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/parsers/facebook_parser.dart';

import '../test_helper.dart';

main() {
  var faceBookPost = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "facebook_post.json"));

  group("Testig parsing of facebook post data: ", () {
    group("Facebook, ", () {
      test("...", () async {
        var parser = FacebookParser();

        var res = await parser.parseFile(faceBookPost).toList();
        // print(res);

        // for (var post in res) {
        //   print(post.toString());
        // }

        expect(res.isNotEmpty, true);
      });
    });
  });
}
