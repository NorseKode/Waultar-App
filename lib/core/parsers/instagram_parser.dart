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
            yield ProfileModel.fromInstragram(object["profile_user"].first);
          } else if (object.containsKey("media")) {
            yield PostModel.fromJson(object, ParseHelper.profile);
          } else {
            appLogger.logger.info("unknown data: ${object.toString()}");
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
