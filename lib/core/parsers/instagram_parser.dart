import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/exceptions/parse_exception.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/abstracts/abstract_parsers/base_parser.dart';
import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/models/video_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/presentation/widgets/upload/upload_util.dart';

class InstragramParser extends BaseParser {
  @override
  Stream<BaseModel> parseDirectory(Directory directory) async* {
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
  Stream<BaseModel> parseFile(File file) async* {
    try {
      var jsonData = await ParseHelper.getJsonStringFromFile(file);

      await for (final object in _returnEveryJsonObject(jsonData)) {
        if (object is Map<String, dynamic> && object.containsKey("uri")) {
          var dataMap = ParseHelper.jsonDataAsMap(object, "parentKey", [""]);

          switch (Extensions.getFileType(dataMap["uri"])) {
            case FileType.image:
              yield ImageModel.fromJson(dataMap);
              break;
            case FileType.video:
              yield VideoModel.fromJson(dataMap);
              break;
            default:
          }
        }
      }
    } on Tuple2<String, dynamic> catch (e) {
      throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
    } on FormatException catch (e) {
      throw ParseException("Wrong formatted json", file, e);
    }
  }

  static Stream<dynamic> _returnEveryJsonObject(var jsonData) async* {
    if (jsonData is Map<String, dynamic>) {
      yield jsonData;

      for (var value in jsonData.values) {
        await for (final result in _returnEveryJsonObject(value)) {
          yield result;
        }
      }
    } else if (jsonData is List<dynamic>) {
      // yield jsonData;

      for (var item in jsonData) {
        await for (final result in _returnEveryJsonObject(item)) {
          yield result;
        }
      }
    }
  }
}
