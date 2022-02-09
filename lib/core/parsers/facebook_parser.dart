import 'package:tuple/tuple.dart';
import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

import 'dart:io';

import '../../configs/exceptions/parse_exception.dart';
import '../abstracts/abstract_parsers/base_parser.dart';
import 'package:path/path.dart' as path_dart;

import '../models/facebook_post_model.dart';

class FacebookParser extends BaseParser {
  @override
  Stream<BaseModel> parseDirectory(Directory directory) {
    // TODO: implement parseDirectory
    throw UnimplementedError();
  }

  @override
  Stream<BaseModel> parseFile(File file) async* {
    var jsonData = await ParseHelper.getJsonStringFromFile(file);
    // var keysInJsonData = ParseHelper.findAllKeysInJson(jsonData);
    var filename = path_dart.basenameWithoutExtension(file.path);

    try {
      if (filename.contains("post")) {
        for (var post in jsonData) {
          yield FacebookPost.fromJson(ParseHelper.jsonDataAsMap(
              post, "", ["attachements"]));
          // TODO: parse media
        }
      }
    } on Tuple2<String, dynamic> catch (e) {
      throw ParseException(
          "Unexpected error occured in parsing of file", file, e.item2);
    } on FormatException catch (e) {
      throw ParseException("Wrong formatted json", file, e);
    }
  }
}
