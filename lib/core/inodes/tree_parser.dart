// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/inodes/data_builder.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/inodes/json_decider.dart';

class TreeParser {
  final DataCategoryRepository _categoryRepo;
  final DataPointNameRepository _nameRepo;
  final DataPointRepository _dataRepo;

  TreeParser(this._categoryRepo, this._nameRepo, this._dataRepo);

  late String formerFileName;
  late String formerFileParentName;

  late String basePathToFiles;

  Future<void> parseManyPaths(List<String> paths) async {
    if (paths.length > 1) {
      var basePathToFiles = StringBuffer();
      var path1 = paths.first;
      var path2 = paths.last;

      for (var i = 0; i < path1.length; i++) {
        if (path1[i] == path2[i]) {
          basePathToFiles.write(path1[i]);
        } else {
          break;
        }
      }
      this.basePathToFiles = basePathToFiles.toString();
    }

    for (var path in paths) {
      if (Extensions.isJson(path)) {
        await parsePath(path);
      }
    }
    _categoryRepo.updateCounts();
  }

  Future<DataPointName> parsePath(String path) async {
    if (Extensions.isJson(path)) {
      var category = _categoryRepo.getFromFolderName(path);
      var file = File(path);
      var json = await getJson(file);
      var dirtyInitialName = path_dart.basename(path);
      var cleanInitialName = dirtyInitialName.replaceAll(".json", "");

      var name = parseName(json, category, cleanInitialName, null);
      category.dataPointNames.add(name);
      _categoryRepo.updateCategory(category);
      return name;
    } else {
      throw Exception("File extension not supported");
    }
  }

  // ! when this method returns, make sure to add the returned datapointname as child to the category parameter
  DataPointName parseName(dynamic json, DataCategory category,
      String initialName, DataPointName? parent) {
    parent ??= DataPointName(name: _cleanName(initialName));

    if (json is Map<String, dynamic> && json.length == 1) {
      return parseName(
          json.values.first, category, _cleanName(json.keys.first), null);
    }

    // it's a map with several entries and each entry should either be embedded as direct datapoint leaf
    // to the current name, or be split into a new child with the key as name, and attach that name as child to the current name
    var mapToEmbedWith = {};
    if (json is Map<String, dynamic> && json.length > 1) {
      var cleanedMap = flatten(json);

      // we iterate over all the key-value pairs in the map ..
      for (var entry in cleanedMap.entries) {
        // and let the json expert decide what to do with each key-value pair
        final decision = JsonExpert.process({entry.key: entry.value});

        // if the key-value pair is {string:scalar} - the decider saw, that the value was a scalar
        if (decision == Decision.embedAsDataPoint) {
          if (entry.value is List<dynamic> && entry.value.isEmpty) {
            break;
          }
          mapToEmbedWith.addAll({_cleanName(entry.key): entry.value});
        }

        // if the key-value pair is {string:complex} - the decider saw, that the value was map or list
        if (decision == Decision.linkAsNewName) {
          parent.children.add(
              parseName(entry.value, category, _cleanName(entry.key), null));
        }

        if (decision == Decision.linkAsDataPoint) {
          // TODO - implement databuilder fully and use here
          // var builder = DataBuilder(basePathToFiles)
          //   ..setName(parent)
          //   ..setCategory(category)
          //   ..setData(entry.value);
          // parent.dataPoints.add(builder.build());

          var directDataPoint = DataPoint();
          directDataPoint.category.target = category;
          directDataPoint.searchString = parent.name;
          directDataPoint.dataPointName.target = parent;
          directDataPoint.values = jsonEncode(flatten(entry.value));
          directDataPoint.stringName = parent.name;

          parent.dataPoints.add(directDataPoint);
        }
      }
    }

    var listToEmbed = <dynamic>[];
    if (json is List<dynamic>) {
      for (var item in json) {
        final decision = JsonExpert.processListElement(item);

        if (decision == Decision.embedAsDataPoint) {
          listToEmbed.add(item);
        }

        if (decision == Decision.linkAsDataPoint) {
          var directDataPoint = DataPoint();
          directDataPoint.category.target = category;
          directDataPoint.searchString =
              parent.name; // TODO - move this into the builder
          directDataPoint.dataPointName.target = parent;
          directDataPoint.values = jsonEncode(flatten(item));
          directDataPoint.stringName = parent.name;

          parent.dataPoints.add(directDataPoint);
        }

        if (decision == Decision.linkAsNewName) {
          // check for name or title keys to use as name for new subtree
          // typechecking just for safety ..
          // when decision is linkAsNewName for a list element
          // the list element is with high certainty as map
          if (item is Map<String, dynamic>) {
            var nameBasedOnTitle = item['title'];
            if (nameBasedOnTitle != null && nameBasedOnTitle is String) {
              parent.children
                  .add(parseName(item, category, nameBasedOnTitle, null));
            }
            var nameBasedOnName = item['name'];
            if (nameBasedOnName != null && nameBasedOnName is String) {
              parent.children
                  .add(parseName(item, category, nameBasedOnName, null));
            } else {
              parent.children.add(parseName(item, category, initialName, null));
            }
          }
        }
      }
    }

    // if outer json node was a map
    // handle the embedded direct datapoint via the embedded map
    if (mapToEmbedWith.isNotEmpty) {
      var directDataPoint = DataPoint();
      directDataPoint.category.target = category;
      directDataPoint.searchString = parent.name;
      directDataPoint.dataPointName.target = parent;
      directDataPoint.values = jsonEncode(mapToEmbedWith);

      var nameBasedOnTitle = mapToEmbedWith['title'];
      if (nameBasedOnTitle != null && nameBasedOnTitle is String) {
        parent.name = nameBasedOnTitle;
      }

      directDataPoint.stringName = parent.name;
      parent.dataPoints.add(directDataPoint);
    }

    // if outer json node was a list
    // handle the embedded direct datapoint via the embedded list
    if (listToEmbed.isNotEmpty) {
      var directDataPoint = DataPoint();
      directDataPoint.category.target = category;
      directDataPoint.searchString = parent.name;
      directDataPoint.dataPointName.target = parent;
      directDataPoint.values = jsonEncode(listToEmbed);

      directDataPoint.stringName = parent.name;
      parent.dataPoints.add(directDataPoint);
    }

    // parent.dataCategory.target = category;
    parent.count = parent.children.length + parent.dataPoints.length;
    return parent;
  }

  Future<dynamic> getJson(File file) async {
    var json = await file.readAsString();
    return jsonDecode(json);
  }

  bool _isNumeric(String s) => double.tryParse(s) != null;

  // make special cases here for certain datapoints based on which directory they are in
  // for instance, the filename for facebook inbox, should be replaced by the name of the parent directory
  String _cleanName(String filename) {
    String temp = filename.split("_").fold(
        "",
        (previousValue, element) => _isNumeric(element)
            ? previousValue + " "
            : previousValue + element + " ");

    if (temp.trim().endsWith("v2")) return temp.replaceAll("v2", "").trim();

    return temp.trim();
  }
}

Map<String, dynamic> flatten(dynamic json, {String nameToFallBackOn = ""}) {
  var result = _flattenRecurse(nameToFallBackOn, json);
  return result;
}

dynamic _flattenRecurse(String keyState, dynamic acc) {
  // handle json list
  if (acc is List<dynamic>) {
    var count = acc.length;

    if (count == 0) {
      return {keyState: 'no data'};
    }

    if (count == 1) {
      var type = acc.first;
      return _flattenRecurse(keyState, type);
    }

    if (count > 1) {
      var list = [];
      for (var item in acc) {
        if (item is Map<String, dynamic> || item is List<dynamic>) {
          var flattenedInner = _flattenRecurse("", item);
          list.add(flattenedInner);
        } else {
          list.add(item);
        }
      }
      return {keyState: list};
    }
  }

  // handle json map
  if (acc is Map<String, dynamic>) {
    var entries = acc.entries;
    var count = entries.length;

    if (count == 0) {
      return {keyState: "no data"};
    }

    if (count == 1) {
      var key = entries.first.key;
      var value = entries.first.value;
      return _flattenRecurse(key, value);
    }

    if (count > 1) {
      Map<String, dynamic> updated = {};

      for (var item in entries) {
        var key = item.key;
        var value = item.value;

        var flattenedInner = _flattenRecurse(key, value);
        var flattenedKey = flattenedInner.entries.first.key;
        var flattenedValue = flattenedInner.entries.first.value;

        // facebook often stores duplicate datetimes which we just discard
        if (DateTime.tryParse(flattenedValue.toString()) != null &&
            updated.containsValue(flattenedValue)) {
          continue;
        }

        // the recursive call might return a key already existing in the updated map
        // if that is the case, put the returned value with the old key
        if (updated.containsKey(flattenedKey)) {
          if (!updated.containsKey(key)) {
            updated.addAll({key: flattenedValue});
          } else {
            updated.addAll({keyState: flattenedValue});
          }
        } else {
          // TODO - change key to flattenedKey if the results are too unprecise
          updated.addAll({flattenedKey: flattenedValue});
        }
      }

      acc = updated;
    }
  }

  // if the acc is neither a list or map, we reached a leaf
  // e.g. we either reached null, datetime, number, string or bool
  if (keyState.isEmpty) return acc;
  if (acc is String && acc.isEmpty) return {keyState: "no data"};
  if (acc == null) return {keyState: "no data"};

  return {keyState: acc};
}
