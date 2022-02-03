import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';

/// A static class that provides functionality used by many of the parser
/// classes
class ParseHelper {
  /// Traverses a [json] tree, looking for a key in the [keyNames] list
  static String trySeveralNames(var json, List<String> keyNames) {
    // for (var name in keyNames) {
    //   if (json is Map<String, dynamic>) {
    //     if (json.containsKey(name) && json[name] is String) {
    //       return json[name];
    //     }
    // }

    // for (var object in json.values) {
    //   if (object is Map<String, dynamic>) {
    //     return trySeveralNames(object, keyNames);
    //   } else if (object is List<dynamic>) {}
    // }

    dynamic? shortenedJson;
    var results = <String>[];
    var keys = findAllKeysInJson(json);

    if (keys.contains("string_map_data")) {
      // Used for instagram data
      shortenedJson = _findObjectInJsonFromKey(json, "string_map_data");
    }

    if (shortenedJson != null) {
      results = _trySeveralNames(shortenedJson, keyNames, results);
    } else {
      results = _trySeveralNames(json, keyNames, <String>[]);
    }
    

    return results[0];
  }

  static List<String> _trySeveralNames(var json, List<String> keyNames, List<String> results) {
    var possibleResults = <String>[];
    
    for (var name in keyNames) {
      if (json is Map<String, dynamic>) {
        if (json.containsKey(name)) {
          results.add(json[name]);
        } else if (json.containsKey(name) && json.values.contains("value")) {

        } else {
          _trySeveralNames(json.values, keyNames, results);
        }
      } else if (json is List<dynamic>) {
        for (var value in json) {
          if (value is Map<String, dynamic>) {
            if (value.containsKey(name)) {
              results.add(value[name]);
            }
          }
        }
      }

      // if (json is Map<String, dynamic>) {
      //   // Facebook's setup
      //   if (json.containsKey(name) && json[name] is String) {
      //     results.add(json[name]);
      //   }
      //   // Insstagram's setup
      //   else if (json.containsKey(name) &&
      //       json[name] is Map<String, dynamic> &&
      //       json[name].containsKey("value")) {
      //     var temp = json[name];
      //     return json[name]["value"];
      //   } else {
      //     for (var value in json.values) {
      //       results = _trySeveralNames(json, keyNames, results);
      //     }
      //   }
      // } else if (json is List<dynamic>) {
      //   for (var item in json) {
      //     results = _trySeveralNames(json, keyNames, results);
      //   }
      // }
    }

    return possibleResults;
  }

  static _findObjectInJsonFromKey(var json, String key) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey(key)) {
        return json;
      } else {
        _findObjectInJsonFromKey(json.values, key);
      }
    } else if (json is List<dynamic>) {
      for (var item in json) {
        if (item is Map<String, dynamic> && item.containsKey(key)) {
          return item;
        } else {
          _findObjectInJsonFromKey(item, key);
        }
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

  // static copyFolderToDocuments(String dir) async {
  //   var context = p.Context(style: Style.windows);
  //   var files = await FileUploader.getAllFilesFrom(dir);
  //   var appPath = await getApplicationDocumentsDirectory();
  //   var path = context.join(appPath.path, "Waultar");

  //   for (var file in files) {
  //     var tempFile = File(path + file);
  //     var exists = await tempFile.exists();
  //     if (!exists) {
  //       tempFile.create(recursive: true);
  //     }

  //     var oldFile = File(dir + file);
  //     var newPath = context.canonicalize(tempFile.path);
  //     oldFile.copy(context.canonicalize(newPath));
  //   }
  // }

  // static copyFileToDocumentsDirectory(String pathFromDocumentDirectory) async {
  //   var context = p.Context(style: Style.windows);
  //   var appPath = await getApplicationDocumentsDirectory();
  //   var waultarPath = context.join(appPath.path, "Waultar");
  //   var finalPath = context.join(waultarPath, pathFromDocumentDirectory);
  //   var file = File(finalPath);

  //   var exists = await file.exists();
  //   if (exists) {
  //     file.create();
  //   }
  // }

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
    // The data parsed is a josn list
    else if (jsonData is List<dynamic>) {
      for (var item in jsonData) {
        set = _aux(item, set);
      }
    }

    return set;
  }

  /// Goes through all files in a give directory, and reads all keys from the json files it finds
  static Future<Set<String>> findAllKeysFromDirectory(String rootDirectory) async {
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

  /// Writes a set of strings to the file given by the [filePath]
  static _writeSetToFile(Set<String> set, String filePath) {
    var file = File(filePath);
    var sink = file.openWrite();

    for (var string in set) {
      sink.writeln(string);
    }
  }

  static Widget findAllKeysOfJsonAtDirectory(BuildContext context) {
    // var localizer = AppLocalizations.of(context)!;
    var keys = <String>{};
    // ignore: unused_local_variable
    List<File>? files;
    File? saveFile;
    var uploadAmount = 0;

    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text("Find All Keys"),
              children: [
                Form(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            child: const Text("Upload Files"),
                            onPressed: () async {
                              files = await FileUploader.uploadFilesFromDirectory();
                            },
                          ),
                          Text("Amount of files: " + uploadAmount.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: const Text("Choose Save File"),
                            onPressed: () async => saveFile = await FileUploader.uploadSingle(),
                          ),
                          const Text("Upload Destination: "),
                        ],
                      ),
                      SimpleDialogOption(
                        child: const Text("Save"),
                        onPressed: () {
                          _writeSetToFile(keys, saveFile!.path);
                          Navigator.pop(context);
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
      child: const Text('Find All Keys'),
    );
  }
}
