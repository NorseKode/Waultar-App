import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';

/// Auxiliary function used in the findAllKeys function
/// Recursively goes through a json tree, and adds all keys to the [set]
Set<String> aux(dynamic jsonData, Set<String> set) {
  // The data parsed is a json object
  if (jsonData is Map<String, dynamic>) {
    for (var key in jsonData.keys) {
      set.add(key);

      // If the json object contains another object, recursively go through
      // this and add all its keys to the set
      if (jsonData[key] is Map<String, dynamic>) {
        set = aux(jsonData[key], set);
      }
      // If the json object contains another json list , recursively go through
      // this and add all its keys to the set
      else if (jsonData[key] is List<dynamic>) {
        set = aux(jsonData[key], set);
      }
    }
  }
  // The data parsed is a josn list
  else if (jsonData is List<dynamic>) {
    for (var item in jsonData) {
      set = aux(item, set);
    }
  }

  return set;
}

/// Goes through all files in a give directory, and reads all keys from the json files it finds
Future<Set<String>> findAllKeysFromDirectory(String rootDirectory) async {
  var result = Set<String>();
  var rootDir = Directory(rootDirectory);

  var directories = await rootDir.list(recursive: true).toList();

  for (var dir in directories) {
    if (dir.path.contains(".json")) {
      var file = File(dir.path);
      var jsonString = await file.readAsString();
      var jsonData = jsonDecode(jsonString);

      result = aux(jsonData, result);
    }
  }

  return result;
}

Future<Set<String>> findAllKeysInFile(File file, Set<String> set) async {
  var jsonString = await file.readAsString();
  var jsonData = jsonDecode(jsonString);

  set = aux(jsonData, set);

  return set;
}

/// Writes a set of strings to the file given by the [filePath]
void writeSetToFile(Set<String> set, String filePath) {
  var file = File(filePath);
  var sink = file.openWrite();

  for (var string in set) {
    sink.writeln(string);
  }
}

Widget findAllKeysOfJsonAtDirectory(BuildContext context) {
  var keys = <String>{};
  List<File>? files;
  File? saveFile;
  var uploadAmount = 0;

  return TextButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            //TODO translations
            title: Text("Find all keys"),
            children: [
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                          child: Text("Upload Files"),
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
                          child: Text("Choose Save File"),
                          onPressed: () async => saveFile = await FileUploader.uploadSingle(),
                        ),
                        Text("Upload Destination: "),
                      ],
                    ),
                    SimpleDialogOption(
                      child: Text("Save"),
                      onPressed: () {
                        print(saveFile!.path);
                        writeSetToFile(keys, saveFile!.path);
                        print(keys.length);
                        Navigator.pop(context);
                      },
                    ),
                    SimpleDialogOption(
                      child: Text("Cancel"),
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
    child: Text('Find All Keys'),
  );
}

void main() async {
  var res = await findAllKeysFromDirectory("D:\\OneDrive\\NorseKode\\data\\lvolinsta_20211206");
  // var res = await findAllKeys("D:\\OneDrive\\NorseKode\\data\\facebook-lukasvlarsen");
  print(res.length);
  // writeSetToFile(res, ".\\keys-instagram.txt");
  // writeSetToFile(res, ".\\keys-facebook.txt");
}
