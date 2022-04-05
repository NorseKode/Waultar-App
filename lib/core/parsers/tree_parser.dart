// ignore_for_file: avoid_print, unused_field

import 'dart:convert';
import 'dart:io';

import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/helpers/PathHelper.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_name_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/data/entities/misc/service_document.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/parsers/json_decider.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';
import 'package:waultar/startup.dart';

import 'json_decider.dart';

class TreeParser {
  final _appLogger = locator.get<BaseLogger>(instanceName: 'logger');
  final _profileRepo =
      locator.get<ProfileRepository>(instanceName: 'profileRepo');
  final DataCategoryRepository _categoryRepo =
      locator.get<DataCategoryRepository>(instanceName: 'categoryRepo');
  final DataPointNameRepository _nameRepo =
      locator.get<DataPointNameRepository>(instanceName: 'nameRepo');
  final DataPointRepository _dataRepo =
      locator.get<DataPointRepository>(instanceName: 'dataRepo');
  final PerformanceHelper _performanceGlobal =
      locator.get<PerformanceHelper>(instanceName: 'performance');
  late PerformanceHelper _performance;

  TreeParser() {
    _performance = PerformanceHelper(
        pathToPerformanceFile: _performanceGlobal.pathToPerformanceFile);
  }

  late String formerFileName;
  late String formerFileParentName;

  late String basePathToFiles;

  Stream<int> parseManyPaths(
      List<String> paths, ProfileDocument profile) async* {
    var fileCount = 0;

    if (ISPERFORMANCETRACKING) {
      _performance.init(newParentKey: "Parser");
      _performance.startReading(_performance.parentKey);
    }

    if (paths.length > 1) {
      var path1 = paths.first;
      var path2 = paths.last;

      basePathToFiles = PathHelper.getCommonPath(path1, path2);
    }

    int progress = 0;
    for (var path in paths) {
      if (Extensions.isJson(path)) {
        fileCount++;
        await parsePath(path, profile);
        progress = progress + 1;
        yield progress;
      }
    }

    _categoryRepo.updateCounts();

    if (ISPERFORMANCETRACKING) {
      _performance.addData(
        _performance.parentKey,
        duration: _performance.stopReading(_performance.parentKey),
        metadata: <String, dynamic>{
          'File count': fileCount,
        },
      );

      _performance.summary("Tree Parser Performance Data");
    }
  }

  Future<DataPointName> parsePath(String path, ProfileDocument profile) async {
    if (Extensions.isJson(path)) {
      var key = "parsePath";
      if (ISPERFORMANCETRACKING) {
        _performance.startReading(key);
      }

      var service = profile.service.target!;

      var key2 = "getFromFolderName";
      if (ISPERFORMANCETRACKING) {
        _performance.startReading(key2);
      }
      var category = _categoryRepo.getFromFolderName(path, profile);
      if (ISPERFORMANCETRACKING) {
        _performance.addReading(
            _performance.parentKey, key2, _performance.stopReading(key2));
      }

      var key3 = "cleanFileName";
      if (ISPERFORMANCETRACKING) {
        _performance.startReading(key3);
      }
      _appLogger.logger.info(
          "Started Parsing Path: $path, Profile: ${profile.toString()}, Service: ${service.toString()}, Category: $category");
      var file = File(path);
      var json = await getJson(file);
      var dirtyInitialName = path_dart.basename(path);
      var cleanInitialName = dirtyInitialName.replaceAll(".json", "");
      if (ISPERFORMANCETRACKING) {
        _performance.addReading(
            _performance.parentKey, key3, _performance.stopReading(key3));
      }

      var key4 = "parseName";
      if (ISPERFORMANCETRACKING) {
        _performance.startReading(key4);
      }
      var name =
          parseName(json, category, cleanInitialName, profile, service, null);
      if (ISPERFORMANCETRACKING) {
        _performance.addReading(
            _performance.parentKey, key4, _performance.stopReading(key4));
      }

      var key5 = "addCategory";
      if (ISPERFORMANCETRACKING) {
        _performance.startReading(key5);
      }
      category.dataPointNames.add(name);
      _categoryRepo.updateCategory(category);
      _profileRepo.add(profile);
      if (ISPERFORMANCETRACKING) {
        _performance.addReading(
            _performance.parentKey, key5, _performance.stopReading(key5));
      }

      if (ISPERFORMANCETRACKING) {
        _performance.addReading(
            _performance.parentKey, key, _performance.stopReading(key));
      }

      return name;
    } else {
      throw Exception("File extension not supported");
    }
  }

  // ! when this method returns, make sure to add the returned datapointname as child to the category parameter
  DataPointName parseName(
      dynamic json,
      DataCategory category,
      String initialName,
      ProfileDocument profile,
      ServiceDocument service,
      DataPointName? parent) {
    parent ??= DataPointName(name: _cleanName(initialName));

    if (json is Map<String, dynamic> && json.length == 1) {
      return parseName(json.values.first, category, _cleanName(json.keys.first),
          profile, service, null);
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
          parent.children.add(parseName(entry.value, category,
              _cleanName(entry.key), profile, service, null));
        }

        if (decision == Decision.linkAsDataPoint) {
          var directDataPoint = DataPoint.parse(
            category,
            parent,
            profile,
            entry.value,
            basePathToFiles,
          );

          _appLogger.logger.info(
              "Parsed Decision: Direct Data Point: ${directDataPoint.toString()}");

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
          var directDataPoint = DataPoint.parse(
            category,
            parent,
            profile,
            item,
            basePathToFiles,
          );

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
              parent.children.add(parseName(
                  item, category, nameBasedOnTitle, profile, service, null));
            }
            var nameBasedOnName = item['name'];
            if (nameBasedOnName != null && nameBasedOnName is String) {
              parent.children.add(parseName(
                  item, category, nameBasedOnName, profile, service, null));
            } else {
              parent.children.add(parseName(
                  item, category, initialName, profile, service, null));
            }
          }
        }
      }
    }

    // if outer json node was a map
    // handle the embedded direct datapoint via the embedded map
    if (mapToEmbedWith.isNotEmpty) {
      var directDataPoint = DataPoint.parse(
        category,
        parent,
        profile,
        mapToEmbedWith,
        basePathToFiles,
      );

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
      var directDataPoint = DataPoint.parse(
        category,
        parent,
        profile,
        listToEmbed,
        basePathToFiles,
      );
      parent.dataPoints.add(directDataPoint);
    }

    parent.profile.target = profile;
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
