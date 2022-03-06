import 'dart:convert';
import 'dart:io';

import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

import '../../configs/globals/media_extensions.dart';
import '../models/media/file_model.dart';
import '../models/media/image_model.dart';
import '../models/media/link_model.dart';
import '../models/media/media_model.dart';
import '../models/media/video_model.dart';

/// A static class that provides functionality used by many of the parser
/// classes
class ParseHelper {
  // TODO : get from repo at startup time
  static ProfileModel profile = ProfileModel(
      activities: [],
      createdTimestamp: DateTime.now(),
      emails: [],
      fullName: '',
      raw: '',
      uri: Uri(),
      service: facebook);
  static ServiceModel facebook = ServiceModel(
      id: 1, name: "facebook", company: "meta", image: Uri(path: ""));
  static ServiceModel instagram = ServiceModel(
      id: 2, name: "instagram", company: "meta", image: Uri(path: ""));

  static MediaModel? parseMedia(var jsonData, String mediaKey) {
    switch (Extensions.getFileType(jsonData[mediaKey])) {
      case FileType.image:
        return ImageModel.fromJson(jsonData, profile);
      case FileType.video:
        return VideoModel.fromJson(jsonData, profile);
      case FileType.file:
        return FileModel.fromJson(jsonData, profile);
      case FileType.link:
        return LinkModel.fromJson(jsonData, profile);
      default:
        return null;
    }
  }
  
  static MediaModel? parseMediaNoKnownKey(var jsonData, ProfileModel profile) {
    var mediaKey = mediaKeys.firstWhere((element) => jsonData.containsKey(element));
    var media = jsonData[mediaKey];
    var pathKey = pathKeys.firstWhere((element) => media.containsKey(element));
    var isLink = jsonData.containsKey("url");


    if (isLink) {
      return LinkModel.fromJson(jsonData, profile);
    } else {
      switch (Extensions.getFileType(media[pathKey])) {
        case FileType.image:
          return ImageModel.fromJson(jsonData, profile);
        case FileType.video:
          return VideoModel.fromJson(jsonData, profile);
        case FileType.file:
          return FileModel.fromJson(jsonData, profile);
        case FileType.link:
          return LinkModel.fromJson(jsonData, profile);
        default:
          return null;
      }
    }

  }

  static Stream<dynamic> returnEveryJsonObject(var jsonData) async* {
    if (jsonData is Map<String, dynamic>) {
      yield jsonData;

      for (var value in jsonData.values) {
        await for (final result in returnEveryJsonObject(value)) {
          yield result;
        }
      }
    } else if (jsonData is List<dynamic>) {
      // yield jsonData;

      for (var item in jsonData) {
        await for (final result in returnEveryJsonObject(item)) {
          yield result;
        }
      }
    }
  }

  static Stream<dynamic> readObjects(
      var data, List<String> keysToLookFor) async* {
    if (data is Map<String, dynamic>) {
      for (var key in keysToLookFor) {
        if (data.containsKey(key)) {
          yield data[key];
        }
      }
      for (var value in data.values) {
        readObjects(value, keysToLookFor);
      }
    } else if (data is List<dynamic>) {
      for (var item in data) {
        if (item is Map<String, dynamic>) {
          for (var key in keysToLookFor) {
            if (item.containsKey(key)) {
              yield item;
            }
          }
        }

        readObjects(item, keysToLookFor);
      }
    }
  }

  static Map<String, dynamic> jsonDataAsMap(
      var json, String parentKey, List<String> keysToExclude) {
    return _jsonDataAsMap(json, parentKey, <String, dynamic>{}, keysToExclude);
  }

  static Map<String, dynamic> _jsonDataAsMap(var json, String parentKey,
      Map<String, dynamic> acc, List<String> keysToExclude) {
    if (json is Map<String, dynamic>) {
      for (var key in json.keys) {
        if (!keysToExclude.contains(key)) {
          if (key == "value") {
            acc[parentKey] = json["value"];
          } else if (json[key] is String ||
              json[key] is bool ||
              json[key] is int) {
            acc[key] = json[key];
          } else {
            acc = _jsonDataAsMap(json[key], key, acc, keysToExclude);
          }
        }
      }
    } else if (json is List<dynamic>) {
      var items = <dynamic>[];

      for (var item in json) {
        if (item is String) {
          items.add(item);
        } else if (item is bool) {
          items.add(item);
        } else if (item is int) {
          items.add(item);
        } else if (item != null) {
          acc = _jsonDataAsMap(item, parentKey, acc, keysToExclude);
        }
      }

      acc[parentKey] = items;
    }

    return acc;
  }

  /// Traverses a [json] tree, looking for a key in the [keyNames] list
  static String trySeveralNames(
      Map<String, dynamic> possibleValues, List<String> keyNames) {
    var keysInMap = keyNames.where((key) => possibleValues.containsKey(key));

    if (keysInMap.isEmpty) {
      return "";
    } else {
      var result = possibleValues[keysInMap.first];

      if (result is List<dynamic>) {
        return result[0];
      } else {
        return result;
      }
    }
  }

  /// Given a [path] converts the file into a json string, no validation is done
  static getJsonStringFromPath(String path) async {
    File file = File(path);
    var jsonString = await file.readAsString();
    return jsonDecode(jsonString);
  }

  /// Given a [file] converts the file into a json string, no validation is done
  static getJsonStringFromFile(File file) async {
    var jsonString = await file.readAsString();
    return jsonDecode(jsonString);
  }

  /// Auxiliary function used in the findAllKeys function
  /// Recursively goes through a json tree, and adds all keys to the [set]
  static _aux(dynamic jsonData, Set<String> set) {
    // The data parsed is a json object
    if (jsonData is Map<String, dynamic>) {
      for (var key in jsonData.keys) {
        set.add(key);

        // If the json object contains another object, recursively go through
        // this and add all its keys to the set
        if (jsonData[key] is Map<String, dynamic>) {
          set = _aux(jsonData[key], set);
        }
        // If the json object contains another json list , recursively go through
        // this and add all its keys to the set
        else if (jsonData[key] is List<dynamic>) {
          set = _aux(jsonData[key], set);
        }
      }
    }
    // The data parsed is a json list
    else if (jsonData is List<dynamic>) {
      for (var item in jsonData) {
        set = _aux(item, set);
      }
    }

    return set;
  }

  /// Goes through all files in a give directory, and reads all keys from the json files it finds
  static Future<Set<String>> findAllKeysFromDirectory(
      String rootDirectory) async {
    var result = <String>{};
    var rootDir = Directory(rootDirectory);

    var directories = await rootDir.list(recursive: true).toList();

    for (var dir in directories) {
      if (dir.path.contains(".json")) {
        var file = File(dir.path);
        var jsonString = await file.readAsString();
        var jsonData = jsonDecode(jsonString);

        result = _aux(jsonData, result);
      }
    }

    return result;
  }

  static Future<Set<String>> findAllKeysInFile(File file) async {
    var set = <String>{};
    var jsonString = await file.readAsString();
    var jsonData = jsonDecode(jsonString);

    set = _aux(jsonData, set);

    return set;
  }

  static Set<String> findAllKeysInJson(var data) {
    var set = <String>{};

    set = _aux(data, set);

    return set;
  }

  static bool probeJsonMap(
      var jsonData, List<String> keysToLookFor, int amountOfUniqueKeysNeeded) {
    var keys = ParseHelper.findAllKeysInJson(jsonData);

    var result = keys.where((e) => keysToLookFor.contains(e));

    return result.length >= amountOfUniqueKeysNeeded ? true : false;
  }

  // /// Writes a set of strings to the file given by the [filePath]
  // static _writeSetToFile(Set<String> set, String filePath) {
  //   var file = File(filePath);
  //   var sink = file.openWrite();

  //   for (var string in set) {
  //     sink.writeln(string);
  //   }
  // }

  // static Widget findAllKeysOfJsonAtDirectory(BuildContext context) {
  //   // var localizer = AppLocalizations.of(context)!;
  //   var keys = <String>{};
  //   // ignore: unused_local_variable
  //   List<File>? files;
  //   File? saveFile;
  //   var uploadAmount = 0;

  //   return TextButton(
  //     onPressed: () {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return SimpleDialog(
  //             title: const Text("Find All Keys"),
  //             children: [
  //               Form(
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         TextButton(
  //                           child: const Text("Upload Files"),
  //                           onPressed: () async {
  //                             files =
  //                                 await FileUploader.uploadFilesFromDirectory();
  //                           },
  //                         ),
  //                         Text("Amount of files: " + uploadAmount.toString()),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         TextButton(
  //                           child: const Text("Choose Save File"),
  //                           onPressed: () async =>
  //                               saveFile = await FileUploader.uploadSingle(),
  //                         ),
  //                         const Text("Upload Destination: "),
  //                       ],
  //                     ),
  //                     SimpleDialogOption(
  //                       child: const Text("Save"),
  //                       onPressed: () {
  //                         _writeSetToFile(keys, saveFile!.path);
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                     SimpleDialogOption(
  //                       child: const Text("Cancel"),
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //     child: const Text('Find All Keys'),
  //   );
  // }
}
