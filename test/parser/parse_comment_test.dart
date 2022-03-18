import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/content/comment_model.dart';
import 'package:waultar/core/models/media/image_model.dart';
import 'package:waultar/core/models/media/link_model.dart';
import 'package:waultar/core/models/media/video_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';

import '../test_helper.dart';

main() {
  // var facebookProfile = TestHelper.facebookProfile;
  // var instagramProfile = TestHelper.instagramProfile;
  // var facebookComments =
  //     File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "facebook_comments.json"));
  // var instagramComments =
  //     File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "post_comments.json"));

  // setUpAll(() {
  //   TestHelper.clearTestLogger();
  //   TestHelper.createTestLogger();
  // });

  // group("Parsing of comments: ", () {
  //   test("Facebook comments: ", () async {
  //     var results = await FacebookParser().parseFile(facebookComments, profile: facebookProfile).toList();

  //     expect(results.length, 10);

  //     var comments = results.whereType<CommentModel>().toList();

  //     expect(comments.length, 8);

  //     expect(comments[0].group!.name, "REDACTED GROUP");
  //     expect(comments[1].text, "REDACTED COMMENT");
  //     expect(comments[1].commented.name, "REDACTED PERSON");
  //     expect(comments[2].media!.first is ImageModel, true);
  //     expect(comments[3].media!.first is LinkModel, true);
  //     expect(comments[4].media!.first is VideoModel, true);
  //     expect(comments[5].commented.name, "PROFILE");
  //     expect(comments[7].event!.name, "REDACTED NAME");
  //   });

  //   test('Instagram comments: ', () async {
  //     var results = await InstagramParser().parseFile(instagramComments, profile: instagramProfile).toList();

  //     expect(results.length, 2);

  //     var comment1 = results[0] as CommentModel;
  //     var comment2 = results[1] as CommentModel;

  //     expect(comment1.text, "The comment");
  //     expect(comment2.text, "The comment");
  //     expect(comment1.commented.name, "username");
  //     expect(comment2.commented.name, "username");
  //     expect(comment1.timestamp, ModelHelper.intToTimestamp(1550618520));
  //     expect(comment2.timestamp, ModelHelper.intToTimestamp(1550712540));
  //   });
  // });
}
