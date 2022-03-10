// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/inode.dart';
import 'package:path/path.dart' as path_dart;

class NewParser {
  final DataCategoryRepository _categoryRepo;
  final DataPointNameRepository _nameRepo;
  final DataPointRepository _dataRepo;

  NewParser(this._categoryRepo, this._nameRepo, this._dataRepo);

  late String formerFileName;
  late String formerFileParentName;

  Future<List<DataPoint>> parseFromPath(String path) async {
    if (Extensions.isJson(path)) {
      var category = _categoryRepo.getFromFolderName(path);

      var file = File(path);
      var json = await getJson(file);
      var parent = DataPoint(values: "");
      var dirtyInitialName = path_dart.basename(path);
      var cleanInitialName = dirtyInitialName.replaceAll(".json", "");

      var listToReturn = <DataPoint>[];
      await for (var dataPoint
          in parseJson(json, category, cleanInitialName, parent)) {
        // this is where we can extract other stuff from the datapoint!
        // likes, images and timestamps for instance
        listToReturn.add(dataPoint);
      }
      _categoryRepo.updateCount(category, listToReturn.length);

      // instead of returning the datapoints, put them in db
      // but for now while testing, just return them!
      return listToReturn;
    } else {
      throw Exception("File extension not supported");
    }
  }

  // client will have to jsonDecode the filecontent before invoking this method
  // and also get the category via the filePath from category Repo
  Stream<DataPoint> parseJson(dynamic json, DataCategory category,
      String dataPointName, DataPoint parent) async* {
    try {
      if (json is List<dynamic>) {
        DataPointName name = DataPointName(name: _cleanName(dataPointName));
        name.dataCategory.target = category;

        // handle scalar items in list
        if (json.first is Map<String, dynamic> == false) {
          parent.dataPointName.target = name;
          name.count += json.length;
          parent.values = jsonEncode(json);
          yield parent;
        }

        // handle list of maps
        // fb posts for instance
        if (json.first is Map<String, dynamic>) {
          for (var map in json) {
            var dataPoint = DataPoint(values: jsonEncode(flatten(map)));
            dataPoint.dataPointName.target = name;
            name.count++;
            yield dataPoint;
          }
        }
      }

      if (json is Map<String, dynamic>) {
        if (json.isNotEmpty) {
          int count = json.length;

          if (count == 1) {
            // recently_viewed
            // but also profile information
            var innerValue = json.entries.first.value;
            String outerKey = json.entries.first.key;

            // case like recently viewed
            if (innerValue is List<dynamic>) {}

            // case like profile_information
            if (innerValue is Map<String, dynamic>) {
              // int innerCount = innerValue.length;
              // var newName = DataPointName(name: _cleanName(outerKey));
              // var flattenedInner = flatten(innerValue);

              yield* parseJson(
                  flatten(innerValue), category, _cleanName(outerKey), parent);

              // this is where a recursive call should be made
            }
          }

          if (count > 1) {
            // facebook messages for instance
            // but also a recursive call when parsing profile

            // decide which should be in the parent datapoint and which should be split out to children
            var entries = json.entries;
            List<Tuple3<String, String, dynamic>> keyAndType = [];

            for (var entry in entries) {
              String key = entry.key;
              var value = entry.value;

              // determine value runtimeType
              if (value is List<dynamic>) {
                keyAndType.add(Tuple3(key, "list_type", value));
              } else if (value is Map<String, dynamic>) {
                keyAndType.add(Tuple3(key, "map_type", value));
              } else {
                // it's either a string, num, bool or null
                keyAndType.add(Tuple3(key, "include_in_parent", value));
              }
            }

            var outerMap = <String, dynamic>{};
            List<DataPoint> children = <DataPoint>[];

            for (var keyType in keyAndType) {
              if (keyType.item2 == "include_in_parent") {
                outerMap.addAll({_cleanName(keyType.item1): keyType.item3});
              }

              if (keyType.item2 == "map_type") {
                if (keyType.item3.length > 1) {
                  var newName = DataPointName(name: _cleanName(keyType.item1));
                  var newPoint = DataPoint(values: "");
                  newPoint.values = jsonEncode(flatten(keyType.item3));
                  newName.dataCategory.target = category;
                  newPoint.dataPointName.target = newName;
                  children.add(newPoint);
                } else {
                  outerMap.addAll({_cleanName(keyType.item1): keyType.item3});
                }
              }

              if (keyType.item2 == "list_type") {
                var count = keyType.item3.length;

                if (count == 0) {
                  outerMap.addAll({_cleanName(keyType.item1): "no data"});
                }

                if (count >= 1) {
                  // determine the type in the list and whether it should be split to children
                  // or included in parent datapoint
                  var firstEntry = keyType.item3.first;
                  if (firstEntry is Map<String, dynamic>) {
                    // split them out and add these nested datapoints as children
                    DataPointName name =
                        DataPointName(name: _cleanName(keyType.item1));
                    name.dataCategory.target = category;
                    for (var inner in keyType.item3) {
                      var dataPoint = DataPoint(values: jsonEncode(flatten(inner)));
                      dataPoint.dataPointName.target = name;
                      children.add(dataPoint);
                    }
                  }
                }
              }
            }

            bool outerIsOnlyName = false;
            if (outerMap.isEmpty) {
              outerIsOnlyName = true;
            }
            if (outerMap.length == 1) {
              if (outerMap.keys.first.trim().isEmpty) {
                outerIsOnlyName = true;
              }
            }

            var parentDataPoint = DataPoint(
                values: outerIsOnlyName ? "" : jsonEncode(flatten(outerMap)));

            if (children.isNotEmpty) {
              parentDataPoint.children.addAll(children);
            }

            var name = DataPointName(name: _cleanName(dataPointName));
            name.dataCategory.target = category;

            var nameBasedOnName = outerMap["name"];
            if (nameBasedOnName != null && nameBasedOnName is String) {
              name.name = nameBasedOnName;
            }

            var nameBasedOnTitle = outerMap["title"];
            if (nameBasedOnTitle != null && nameBasedOnTitle is String) {
              name.name = nameBasedOnTitle;
            }

            parentDataPoint.dataPointName.target = name;
            name.count += outerMap.length;
            name.count += children.length;

            yield parentDataPoint;
          }
        }
      }
    } catch (e) {
      print(e);
    }
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

    if (temp.trim().endsWith("v2")) return temp.replaceAll("v2", "");

    return temp.trim();
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
            updated.addAll(flattenedInner);
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
}
