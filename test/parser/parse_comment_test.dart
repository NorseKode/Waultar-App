import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/content/comment_model.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';

import '../test_helper.dart';

main() {
  var facebookProfile = TestHelper.facebookProfile;
  var instagramProfile = TestHelper.instagramProfile;
  var facebookComments =
      File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "comments.json"));
  var instagramComments =
      File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "post_comments.json"));

  setUpAll(() {
    TestHelper.clearTestLogger();
    TestHelper.createTestLogger();
  });

  group("Parsing of comments: ", () {
    // test("Facebook comments: ", () {
    //   var results = FacebookParser().parseFile(facebookComments, profile: facebookProfile);


    // });

    test('Instagram comments: ', () async {
      var results = await InstagramParser().parseFile(instagramComments, profile: instagramProfile).toList();

      expect(results.length, 2);

      var comment1 = results[0] as CommentModel;
      var comment2 = results[1] as CommentModel;

      expect(comment1.text, "The comment");
      expect(comment2.text, "The comment");
      expect(comment1.timestamp, 1550618520);
      expect(comment2.timestamp, 1550712540);
    });
  });
}
