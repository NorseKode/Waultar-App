import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';

import '../test_helper.dart';

main() {
  var faceBookPost = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "facebook_post.json"));
  var instagramPost = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "instagram_post.json"));

  group("Testig parsing of post data: ", () {
    group("Instagram", () {
      test("Parse all post", () async {
        var parser = InstagramParser();
        var res = await parser.parseFile(instagramPost).toList();
        var postCount = 0;

        for (var post in res) {
          if (post is PostModel) {
            postCount++;
          }
        }
        expect(postCount, 5);
      });
    });
    group("Facebook", () {
      group("General", () {
        test("Parse all post", () async {
          var parser = FacebookParser();
          var res = await parser.parseFile(faceBookPost).toList();
          var postCount = 0;

          for (var post in res) {
            if (post is PostModel) {
              postCount++;
            }
          }
          expect(postCount, 14);
        });
        test("Parse post with no data", () async {
          var parser = FacebookParser();
          var posts = await parser.parseFile(faceBookPost).toList();

          List<PostModel> postsObjects = [];
          for (var post in posts) {
            if (post is PostModel) {
              postsObjects.add(post);
            }
          }

          var res = postsObjects[11];

          expect(res.toString().isNotEmpty, true);
        });
      });
      group("Title", () {
        test("Post with title", () async {
          var parser = FacebookParser();
          var posts = await parser.parseFile(faceBookPost).toList();

          List<PostModel> postsObjects = [];
          for (var post in posts) {
            if (post is PostModel) {
              postsObjects.add(post);
            }
          }
          var res = postsObjects[0].title;

          expect(res, "Sne sne!");
        });
      });
      group("Event", () {
        test("Post with event", () async {
          var parser = FacebookParser();
          var posts = await parser.parseFile(faceBookPost).toList();

          List<PostModel> postsObjects = [];
          for (var post in posts) {
            if (post is PostModel) {
              postsObjects.add(post);
            }
          }
          var res = postsObjects[9].event?.name;

          expect(res, "Shinson Hapkido Internationalt Kampkunstshow");
        });
      });
    });
  });
}
