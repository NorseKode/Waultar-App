import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/exceptions/parse_exception.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/abstracts/abstract_parsers/base_parser.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/presentation/widgets/upload/upload_util.dart';
import 'package:waultar/startup.dart';

class InstagramParser extends BaseParser {
  var appLogger = locator.get<AppLogger>(instanceName: 'logger');
  ProfileModel? _profile;

  setProfile(ProfileModel profile) {
    _profile = profile;
  }

  @override
  Stream parseListOfPaths(List<String> paths) async* {
    for (var path in paths) {
      if (Extensions.isJson(path)) {
        var file = File(path);
        await for (final result in parseFile(file)) {
          yield result;
        }
      }
    }
  }

  @override
  Stream<dynamic> parseDirectory(Directory directory) async* {
    var files = await getAllFilesFrom(directory.path);

    for (var file in files) {
      if (Extensions.isJson(file.path)) {
        await for (final result in parseFile(file)) {
          yield result;
        }
      }
    }
  }

  @override
  Stream<dynamic> parseFile(File file) async* {
    try {
      var jsonData = await ParseHelper.getJsonStringFromFile(file);

      await for (final object in ParseHelper.returnEveryJsonObject(jsonData)) {
        if (object is Map<String, dynamic>) {
          if (object.containsKey("profile_user")) {
            var result = ProfileModel.fromInstragram(object["profile_user"].first);
            appLogger.logger.info("parsed object: ${result.toString()}");
            yield result;
          } else if (object.containsKey("media")) {
            var result = PostModel.fromJson(object, _profile ?? ParseHelper.profile);
            appLogger.logger.info("parsed object: ${result.toString()}");
            yield result;
          } else {
            // appLogger.logger.info("unknown data: ${object.toString()}");
          }

          //   var dataMap = ParseHelper.jsonDataAsMap(object, "parentKey", [""]);

          //   switch (Extensions.getFileType(dataMap["uri"])) {
          //     case FileType.image:
          //       yield ImageModel.fromJson(dataMap, ParseHelper.profile);
          //       break;
          //     case FileType.video:
          //       yield VideoModel.fromJson(dataMap, ParseHelper.profile);
          //       break;
          //     default:
          //   }
        }
      }
    } on Tuple2<String, dynamic> catch (e) {
      throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
    } on FormatException catch (e) {
      throw ParseException("Wrong formatted json", file, e);
    }
  }
}
