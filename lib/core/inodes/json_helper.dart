import 'dart:convert';
import 'dart:io';

Map<String, dynamic> determineSchema(dynamic json, String fileName) {

  if (json is List<dynamic>) {
    var map = {fileName: json};
    var node = Node(fileName); // create root
    // node.add(json);
  } 

  if (json is Map<String, dynamic>) {

  }



  var result = <String, dynamic>{};

  result.putIfAbsent(fileName, () => null);

  // combine all different entries of the input json
  // and make a map that acts as the superset schema
  crawl(dynamic input) {

    if (input is List<dynamic>) {

    }

    if (input is Map<String, dynamic>) {

    }
  }

  crawl(json);
  return result;
}

void merge(dynamic previous, dynamic current) {

}

class JsonTree {

  Node root;

  JsonTree(this.root);

}

class Node {

  // unique keyname inside nested json structure
  final String key;

  List<String> valueTypes = [];
  List<Node> children = [];

  Node(this.key);

}


dynamic inferFromFile(File file) async {
  try {
    var stringData = await file.readAsString();
    // var json = jsonDecode(stringData);
    return determineSchema(stringData, file.path);
  } catch (e) {
    print(e);
  }
}