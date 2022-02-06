import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/exceptions/parse_exception.dart';
import 'package:waultar/core/abstracts/abstract_parsers/base_parser.dart';
import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

class InstragramParser extends BaseParser {
  @override
  Stream<BaseModel> parseDirectory(Directory directory) async* {
    // var files = await getAllFilesFrom(directory.path);

    // for (var file in files) {
    //   if (dart_path.extension(file.path) == '.json') {
    //     parseFile(file).listen((data) {
    //       yield data;
    //     });
    //   }
    // }
  }

  @override
  Stream<BaseModel> parseFile(File file) async* {
    var jsonData = await ParseHelper.getJsonStringFromFile(file);
    var keysInJsonData = ParseHelper.findAllKeysInJson(jsonData);

    try {
      if (keysInJsonData.contains("media")) {
        var objectsOfInterests = await ParseHelper.readObjects(jsonData, "media").toList();

        for (var object in objectsOfInterests) {
          for (var media in object["media"]) {
            yield ImageModel.fromJson(ParseHelper.jsonDataAsMap(media, "", <String, dynamic>{}));
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
