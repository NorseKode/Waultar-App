import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/image_model.dart';
import 'package:waultar/core/models/video_model.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';

import '../test_helper.dart';

main() {
  var instagramMedia = File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "instagram_media.json"));

  group("Testig parsing of media data: ", () {
    group("Instagram, ", () {
      test("mixed media data, parse single file", () async {
        // 3 videos 1 image
        var imageCount = 0;
        var videoCount = 0;
        var medias = await InstragramParser().parseFile(instagramMedia).toList();

        expect(medias.length, 4);

        for (var media in medias) {
          if (media is ImageModel) {
            imageCount++;
          } else if (media is VideoModel) {
            videoCount++;
          }
        }

        expect(1, imageCount);
        expect(3, videoCount);
      });
    });
  });
}
