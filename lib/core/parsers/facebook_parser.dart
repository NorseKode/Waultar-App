import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/media/file_model.dart';
import 'package:waultar/core/models/media/image_model.dart';
import 'package:waultar/core/models/media/link_model.dart';
import 'package:waultar/core/models/media/video_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

import 'dart:io';

import '../../configs/exceptions/parse_exception.dart';
import '../abstracts/abstract_parsers/base_parser.dart';
import 'package:path/path.dart' as path_dart;

class FacebookParser extends BaseParser {
  @override
  Stream<dynamic> parseDirectory(Directory directory) {
    // TODO: implement parseDirectory
    throw UnimplementedError();
  }

  @override
  Stream<dynamic> parseFile(File file) async* {
    try {
      var jsonData = await ParseHelper.getJsonStringFromFile(file);
      var filename = path_dart.basenameWithoutExtension(file.path);
      const mediaKeys = ["uri", "content", "link"];
      var uriAlreadyUsed = [];
      var isPosts = filename.contains("post");

      if (filename.contains("post")) {
        for (var post in jsonData) {
          yield PostModel.fromJson(post, ParseHelper.profile);
        }
      }

      await for (final object in ParseHelper.returnEveryJsonObject(jsonData)) {
        if (object is Map<String, dynamic>) {
          if (isPosts) {
            // skip
          } else if (object.containsKey("profile_v2")) {
            // TODO: parse groups
            yield ProfileModel.fromFacebook(object["profile_v2"]);
          } else {
            var mediaKey =
                object.keys.firstWhere((key) => mediaKeys.contains(key), orElse: () => "");

            if (mediaKey != "" && !uriAlreadyUsed.contains(object[mediaKey])) {
              switch (Extensions.getFileType(object[mediaKey])) {
                case FileType.image:
                  uriAlreadyUsed.add(object[mediaKey]);
                  yield ImageModel.fromJson(object, ParseHelper.profile);
                  break;
                case FileType.video:
                  uriAlreadyUsed.add(object[mediaKey]);
                  yield VideoModel.fromJson(object, ParseHelper.profile);
                  break;
                case FileType.file:
                  uriAlreadyUsed.add(object[mediaKey]);
                  yield FileModel.fromJson(object, ParseHelper.profile);
                  break;
                case FileType.link:
                  if (object[mediaKey] is String &&
                      !object[mediaKey].startsWith("https://interncache")) {
                    uriAlreadyUsed.add(object[mediaKey]);
                    yield LinkModel.fromJson(object, ParseHelper.profile);
                  }
                  break;
                default:
                  break;
              }
            }
          }
        }
      }
    } on Tuple2<String, dynamic> catch (e) {
      throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
    } on FormatException catch (e) {
      throw ParseException("Wrong formatted json", file, e);
    }
  }
}
