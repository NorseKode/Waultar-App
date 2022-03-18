import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/media/file_model.dart';
import 'package:waultar/core/models/media/image_model.dart';
import 'package:waultar/core/models/media/link_model.dart';
import 'package:waultar/core/models/media/video_model.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';

import '../test_helper.dart';

main() {
  // var instagramMedia =
  //     File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "instagram_media.json"));
  // var facebookMedia =
  //     File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "facebook_media.json"));

  // setUpAll(() {
  //   TestHelper.clearTestLogger();
  //   TestHelper.createTestLogger();
  // });

  // group("Testig parsing of media data: ", () {
  //   group("Instagram, ", () {
  //     test("mixed media data, parse single file", () async {
  //       // 3 videos 1 image
  //       // var imageCount = 0;
  //       // var videoCount = 0;
  //       var medias = await InstagramParser()
  //           .parseFile(instagramMedia, profile: TestHelper.instagramProfile)
  //           .toList();

  //       expect(medias.length, 5);

  //       // for (var media in medias) {
  //       //   if (media is ImageModel) {
  //       //     imageCount++;
  //       //   } else if (media is VideoModel) {
  //       //     videoCount++;
  //       //   }
  //       // }

  //       // expect(imageCount, 1);
  //       // expect(videoCount, 3);
  //     });
  //   });

  //   group("Facebook, ", () {
  //     test("mixed media data, parse single file", () async {
  //       var imageCount = 0;
  //       var videoCount = 0;
  //       var fileCount = 0;
  //       var linkCount = 0;

  //       var medias = await FacebookParser()
  //           .parseFile(facebookMedia, profile: TestHelper.facebookProfile)
  //           .toList();

  //       expect(medias.length, 9);

  //       for (var media in medias) {
  //         if (media is ImageModel) {
  //           imageCount++;
  //         } else if (media is VideoModel) {
  //           videoCount++;
  //         } else if (media is FileModel) {
  //           fileCount++;
  //         } else if (media is LinkModel) {
  //           linkCount++;
  //         }
  //       }

  //       expect(imageCount, 2);
  //       expect(videoCount, 2);
  //       expect(fileCount, 2);
  //       expect(linkCount, 3);
  //     });
  //   });
  // });
}
