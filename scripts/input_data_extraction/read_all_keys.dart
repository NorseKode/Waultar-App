// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path_dart;
import 'package:pretty_json/pretty_json.dart';

final scriptDir = File(Platform.script.toFilePath()).parent;
Future main(List<String> args) async {

  // read the directory path given in command line
  if (args.isEmpty) {
    print('please provide the path to the directory to read files from');
    exit(0);
  }
  final String path = args.first;
  final Directory dataDir = getDirectory(path);

  // load all files with .json
  final List<File> jsonFiles = await dirContents(dataDir);

  // recursively go through json file and add each key to a map
  Map<String, int> keys = {};
  for (var file in jsonFiles) {
    var json = await getJson(file);
    var fileKeys = getAllUniqueKeys(json);
    for (var entry in fileKeys.entries) {
      keys.update(entry.key, (value) => value + entry.value, ifAbsent: () => entry.value);
    }
  }

  var keysList = keys.entries.toList();
  keysList.sort((a, b) => b.value.compareTo(a.value));
  final outputMap = Map.fromEntries(keysList);

  File outputFileKeys = await File(path_dart.normalize('${scriptDir.path}/script_output/keys.json')).create(recursive: true);
  await outputFileKeys.writeAsString(prettyJson(outputMap));

  // do the same for infering the json schema


  // export the set and schema to another json file
}

Directory getDirectory(String pathFromWaultarRoot) {
  // final scriptDir = File(Platform.script.toFilePath()).parent;
  final dataDir =
      Directory(path_dart.normalize('${scriptDir.path}/$pathFromWaultarRoot'));
  return dataDir;
}

Future<List<File>> dirContents(Directory dir) {
  var files = <File>[];
  var completer = Completer<List<File>>();
  var lister = dir.list(recursive: true);
  lister.listen((file) {
    if (file is File && file.path.endsWith('.json')) files.add(file);
  }, onDone: () => completer.complete(files));
  return completer.future;
}

Future<dynamic> getJson(File file) async {
  var jsonBytes = await file.readAsBytes();
  return jsonDecode(utf8.decode(jsonBytes));
}

Map<String, dynamic> getJsonSchema(dynamic json) {
  var schema = <String, dynamic>{};

  dynamic aux(dynamic json, int depth) {
    if (json is Map<String, dynamic>) {}

    if (json is List<dynamic>) {
      if (depth == 0) {

      }
    }
  }

  aux(json, 0);
  return schema;
}

Map<String, int> getAllUniqueKeys(dynamic json) {
  Map<String, int> keys = {};

  aux(dynamic json) {
    if (json is Map<String, dynamic>) {
      for (var entry in json.entries) {
        keys.update(entry.key, (value) => value + 1, ifAbsent: () => 1);
        if (entry.value is Map<String, dynamic> || entry.value is List<dynamic>) {
          aux(entry.value);
        }
      }
    }
    if (json is List<dynamic>) {
      for (var item in json) {
        aux(item);
      }
    }
  }

  aux(json);
  return keys;
}
