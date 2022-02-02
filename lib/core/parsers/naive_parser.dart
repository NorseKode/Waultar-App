import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/exceptions/parse_exception.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/presentation/widgets/upload/upload_util.dart';
import 'package:path/path.dart' as dart_path;

/// A naive parser that reads the entire json tree
/// It isn't optimized in anyway, and should only be used for testing
class NaiveParser {
  /// Reads the entire json tree, looking for object of a specific type
  ///
  /// Main function that traverses the json tree stored in [data], where it
  /// collects entities in the [acc] list. It decides whether an object is of
  /// a specififc type with the [isValidObject] that is specific for each
  /// entity i.e. an Image, and creates the object via its constructor provided
  /// in the [constructor] function
  ///
  /// Lastly an optional function [doesFileAlreadyExists] can be given, to
  /// check whether an object is already in the list, i.e. an Image that
  /// already has been loaded once
  static void _readObject<T>(
      List<T> acc,
      var data,
      bool Function(dynamic value) isValidObject,
      bool Function(List<T> acc, T value)? doesFileAlreadyExists,
      T Function(dynamic value) constructor) {
    if (data is Map<String, dynamic>) {
      for (var value in data.values) {
        if (isValidObject(value)) {
          var object = constructor(value);
          if (doesFileAlreadyExists == null) {
            acc.add(object);
          } else if (!doesFileAlreadyExists(acc, object)) {
            acc.add(object);
          }
        } else {
          _readObject<T>(acc, value, isValidObject, doesFileAlreadyExists, constructor);
        }
      }
    } else if (data is List<dynamic>) {
      for (var item in data) {
        var object = constructor(item);

        if (object == null) {
          _readObject<T>(acc, item, isValidObject, doesFileAlreadyExists, constructor);
        } else {
          acc.add(object);
        }
      }
    } else {
      // if something unexpected is encounters, the object is thrown back to
      // the caller
      throw Tuple2("Uknown data", data);
    }
  }

  /// Parses all files in [directory]
  ///
  /// Takes a directory [directory] and reads all files in said directory.
  /// Followed by an parsing of every file in said directory
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  static parseDirectory(Directory directory) async {
    var mapOfAcc = _setupAccumulators();
    var files = await getAllFilesFrom(directory.path);

    for (var file in files) {
      if (dart_path.extension(file.path) == '.json') {
        try {
          var data = await ParseHelper.getJsonStringFromFile(file);
          _imageCriteria(mapOfAcc["Images"]! as List<ImageModel>, data);
        } on Tuple2<String, dynamic> catch (e) {
          throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
        } on FormatException catch (e) {
          throw ParseException("Wrong formatted json", file, e);
        }
      }
    }

    return mapOfAcc;
  }

  /// Parses a single [file]
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  static Future<Map<String, List<BaseModel>>> parseFile(File file) async {
    var mapOfAcc = _setupAccumulators();

    var data = await ParseHelper.getJsonStringFromFile(file);

    try {
      _imageCriteria(mapOfAcc["Images"]! as List<ImageModel>, data);
    } on Tuple2<String, dynamic> catch (e) {
      throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
    } on FormatException catch (e) {
      throw ParseException("Wrong formatted json", file, e);
    }

    return mapOfAcc;
  }

  static Map<String, List<BaseModel>> _setupAccumulators() {
    return {
      "Images": <ImageModel>[],
    };
  }

  static _imageCriteria(List<ImageModel> acc, var data) {
    imageCriteria(var value) =>
        value is Map<String, dynamic> &&
        value.containsKey("media") &&
        value.values.firstWhere(
                (element) =>
                    element is Map<String, dynamic> &&
                    element.keys.contains("uri") &&
                    !element.keys.contains("thumbnail"),
                orElse: () => null) !=
            null;
    isImageAlreadyInList(List<ImageModel> acc, ImageModel img) =>
        acc.where((element) => element.path == img.path).isEmpty ? false : true;

    _readObject<ImageModel>(acc, data, imageCriteria, isImageAlreadyInList, ImageModel.fromJson);
  }
}
