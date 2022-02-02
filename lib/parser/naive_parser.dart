import 'dart:io';

import 'package:waultar/exceptions/parse_exception.dart';
import 'package:waultar/models/tables/base_entity.dart';
import 'package:waultar/models/tables/images_table.dart';
import 'package:waultar/parser/parse_helper.dart';
import 'package:waultar/widgets/upload/upload_util.dart';
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
      throw data;
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
          var data = await getJsonStringFromFile(file);
          _imageCriteria(mapOfAcc["Images"]! as List<Image>, data);
        } catch (e) {
          throw ParseException("Unexpected error occured in parsing of file", file, e);
        }
      }
    }

    return mapOfAcc;
  }

  /// Parses a single [file]
  /// 
  /// Throws an [ParseException] if something unexpected in encountered
  static parseFile(File file) async {
    var mapOfAcc = _setupAccumulators();

    var data = await getJsonStringFromFile(file);

    try {
      _imageCriteria(mapOfAcc["Images"]! as List<Image>, data);
    } catch (e) {
      throw ParseException("Unexpected error occured in parsing of file", file, e);
    }

    return mapOfAcc;
  }

  static Map<String, List<BaseEntity>> _setupAccumulators() {
    return {
      "Images": <Image>[],
    };
  }

  static _imageCriteria(List<Image> acc, String data) {
    imageCriteria(var value) =>
        value is Map<String, dynamic> &&
        value.containsKey("uri") &&
        !value.containsKey("thumbnail");
    isImageAlreadyInList(List<Image> acc, Image img) =>
        acc.where((element) => element.path == img.path).isEmpty ? false : true;

    _readObject<Image>(acc, data, imageCriteria, isImageAlreadyInList, Image.fromJson);
  }
}
