import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/exceptions/parse_exception.dart';
import 'package:waultar/core/abstracts/abstract_parsers/base_parser.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/presentation/widgets/upload/upload_util.dart';
import 'package:path/path.dart' as dart_path;

/// A naive parser that reads the entire json tree
/// It isn't optimized in anyway, and should only be used for testing
class NaiveParser extends BaseParser {
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
  // static void _readObjects<T>(
  //     List<T> acc,
  //     var data,
  //     bool Function(dynamic value) isValidObject,
  //     bool Function(List<T> acc, T value)? doesFileAlreadyExists,
  //     T Function(dynamic value) constructor) {
  //   if (data is Map<String, dynamic>) {
  //     for (var value in data.values) {
  //       if (isValidObject(value)) {
  //         var object = constructor(value);
  //         if (doesFileAlreadyExists == null) {
  //           acc.add(object);
  //         } else if (!doesFileAlreadyExists(acc, object)) {
  //           acc.add(object);
  //         }
  //       } else {
  //         _readObjects<T>(
  //             acc, value, isValidObject, doesFileAlreadyExists, constructor);
  //       }
  //     }
  //   } else if (data is List<dynamic>) {
  //     for (var item in data) {
  //       var object = constructor(item);

  //       if (object == null) {
  //         _readObjects<T>(
  //             acc, item, isValidObject, doesFileAlreadyExists, constructor);
  //       } else {
  //         acc.add(object);
  //       }
  //     }
  //   } else {
  //     // if something unexpected is encounters, the object is thrown back to
  //     // the caller
  //     throw Tuple2("Uknown data", data);
  //   }
  // }

  // static _readObject<T>(var data, bool Function(dynamic value) isValidObject,
  //     T Function(dynamic value) constructor) {
  //   if (data is Map<String, dynamic>) {
  //     if (isValidObject(data)) {
  //       return constructor(data);
  //     } else {
  //       for (var value in data.values) {
  //         if (isValidObject(value)) {
  //           return constructor(value);
  //         } else {
  //           _readObject<T>(value, isValidObject, constructor);
  //         }
  //       }
  //     }
  //   } else if (data is List<dynamic>) {
  //     for (var item in data) {
  //       _readObject<T>(item, isValidObject, constructor);
  //     }
  //   }
  //   // else {
  //   //   // if something unexpected is encounters, the object is thrown back to
  //   //   // the caller
  //   //   throw Tuple2("Uknown data", data);
  //   // }
  // }

  @override
  Stream<BaseModel> parseDirectory(Directory directory) async* {
    var files = await getAllFilesFrom(directory.path);

    for (var file in files) {
      if (dart_path.extension(file.path) == '.json') {
        try {
          // var data = await ParseHelper.getJsonStringFromFile(file);
          // _imageCriteria(mapOfAcc["Images"]! as List<ImageModel>, data);
        } on Tuple2<String, dynamic> catch (e) {
          throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
        } on FormatException catch (e) {
          throw ParseException("Wrong formatted json", file, e);
        }
      }
    }

    // return mapOfAcc;
  }

  @override
  Stream<BaseModel> parseFile(File file, {ProfileModel? profile}) async* {
    // var mapOfAcc = _setupAccumulators();

    var jsonData = await ParseHelper.getJsonStringFromFile(file);
    var isProfileData = _probleJsonMap(jsonData, ["profile_v2", "profile_user"], 1);

    if (isProfileData) {
      // var profile = _profileCriteria(jsonData);
      // var profile = ProfileModel.fromJson2(
      //     _readJsonValuesAsMap(jsonData, "", <String, dynamic>{}));

      // if (profile != null) {
      //   mapOfAcc["Profile"] = profile;
      // }
    }

    // try {
    //   _imageCriteria(mapOfAcc["Images"]! as List<ImageModel>, data);
    // } on Tuple2<String, dynamic> catch (e) {
    //   throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
    // } on FormatException catch (e) {
    //   throw ParseException("Wrong formatted json", file, e);
    // }

    // return mapOfAcc;
  }

  static bool _probleJsonMap(
      var jsonData, List<String> keysToLookFor, int amountOfUniqueKeysNeeded) {
    var keys = ParseHelper.findAllKeysInJson(jsonData);

    var result = keys.where((e) => keysToLookFor.contains(e));

    return result.length >= amountOfUniqueKeysNeeded ? true : false;
  }

  @override
  Stream parseListOfPaths(List<String> paths) {
    // TODO: implement parseListOfPaths
    throw UnimplementedError();
  }

  @override
  Stream parseFileLookForKey(File file, String key) {
    // TODO: implement parseFileLookForKey
    throw UnimplementedError();
  }

  @override
  Future<Tuple2<ProfileModel, List<String>>> parseProfile(List<String> paths, {ServiceModel? service}) {
    // TODO: implement parseProfile
    throw UnimplementedError();
  }

  // static _imageCriteria(List<ImageModel> acc, var data) {
  //   imageCriteria(var value) =>
  //       value is Map<String, dynamic> &&
  //       value.containsKey("media") &&
  //       value.values.firstWhere(
  //               (element) =>
  //                   element is Map<String, dynamic> &&
  //                   element.keys.contains("uri") &&
  //                   !element.keys.contains("thumbnail"),
  //               orElse: () => null) !=
  //           null;
  //   isImageAlreadyInList(List<ImageModel> acc, ImageModel img) =>
  //       acc.where((element) => element.path == img.path).isEmpty ? false : true;

  //   _readObjects<ImageModel>(
  //       acc, data, imageCriteria, isImageAlreadyInList, ImageModel.fromJson);
  // }
}
