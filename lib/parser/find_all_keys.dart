import 'dart:convert';
import 'dart:io';

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
Future<Set<String>> findAllKeys(String rootDirectory) async {
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

/// Writes a set of strings to the file given by the [filePath]
void writeSetToFile(Set<String> set, String filePath) {
  var file = File(filePath);
  var sink = file.openWrite();

  for (var string in set) {
    sink.writeln(string);
  }
}

void main() async {
  var res = await findAllKeys("D:\\OneDrive\\NorseKode\\data\\lvolinsta_20211206");
  // var res = await findAllKeys("D:\\OneDrive\\NorseKode\\data\\facebook-lukasvlarsen");
  print(res.length);
  writeSetToFile(res, ".\\keys-instagram.txt");
}
