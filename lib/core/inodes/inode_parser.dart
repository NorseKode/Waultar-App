import 'dart:convert';
import 'dart:io';

import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/inode.dart';

import 'package:path/path.dart' as path_dart;
import 'package:deep_pick/deep_pick.dart' as key_picker;

class InodeParserService {
  final InodeParser _parser;
  final DataCategoryRepository _categoryRepo;
  final DataPointNameRepository _nameRepo;
  final DataPointRepository _dataRepo;

  InodeParserService(
      this._parser, this._categoryRepo, this._nameRepo, this._dataRepo);

  Future parse(List<String> paths) async {
    /* notes on isolates and objectbox :
        - make sure we one and ONLY one store during entire runtime, never close it!
        - to get better write performance, make sure that put operations are done in chunks transactions 
            - there can only be ONE write transaction at any time
            - these run strictly and sequentially
        - read transactions will never get blocked nor block a write transaction
        - check : https://pub.dev/documentation/objectbox/latest/objectbox/Store-class.html
            - use Store.runIsolated to perform the CRUD in another isolate
            - objectbox api will take care of only handling a single store
    */

    // 1) gets a list<string> paths from the uploader
    // 2) parse each file in an isolate
    //    - each isolate returns a list of dataPoints

    /* consider using the template method pattern
          - divide the parsing algorithm up in steps
          - many steps will be the same for different services
              - facebook and instagram for instance
          - steps in the algorithm that differ from the base (defined in the abstract class)
            can be overidden in the concrete parser implementations
    */
    var category = DataCategory(name: "test");

    for (var path in paths) {
      if (Extensions.isJson(path)) {
        var file = File(path);
        var parentName = path_dart.basename(file.parent.path);

        // get category from service based on parent directory for the file
        // if none is found :
        // keep looking backwards in the path until we reach root folder
        // if still none are found, set category to "Other" (default)
        // var category = DataCategory(name: "test");

        // add the parsed inodes to a list, and when the stream is done
        // put them in db as a large transaction to improve performance
        var listToAdd = <DataPoint>[];
        await for (final result in _parser.parseFile(file)) {
          if (result is DataPoint) {
            result.dataPointName.target!.dataCategory.target = category;

            // ! don't add one at a time - read transactions are okay to do tho
            // _dataRepo.addDataPoint(result); <- never do this when iterating !

            // ! put them in chunks - write transactions becomes vastly better
            listToAdd.add(result);
          }
        }

        // ! now we can initiate a single transaction rather than many
        _dataRepo.addMany(listToAdd);
      }
    }
  }
}

class InodeParser {
  // final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  Stream<dynamic> parseFile(File file) async* {
    try {
      var fileName = path_dart.basename(file.path);
      if (fileName.endsWith('.json')) {
        fileName = fileName.replaceAll(".json", "");
      }

      // TODO : replace corrupted characters in json with correct unicode ..
      // æ, ø, å and emojeys are corrupted
      // this is an error from facebook - they do not send the json in correct utf8 format ..

      var item = await _getJson(file);

      if (item is List<dynamic>) {
        DataPointName name = DataPointName(name: _cleanName(fileName));
        for (var obj in item) {
          DataPoint dataPoint = DataPoint(values: "");
          dataPoint.dataPointName.target = name;
          var map = flatten(obj);
          dataPoint.valuesMap = map;
          dataPoint.values = jsonEncode(map);
          yield dataPoint;
        }
      }

      if (item is Map<String, dynamic>) {
        // if keys has at least on item, we need to parse either one datapoint
        // or a series of data points depending on the type of the value
        if (item.keys.isNotEmpty) {
          int amountOfKeys = item.keys.length;
          String key = item.keys.first;
          var jsonObject = item[key];

          if (amountOfKeys == 1 && jsonObject is List<dynamic>) {
            DataPointName name = DataPointName(name: _cleanName(key));
            for (var obj in jsonObject) {
              DataPoint dataPoint = DataPoint(values: "");
              dataPoint.dataPointName.target = name;
              var map = flatten(obj);
              dataPoint.valuesMap = map;
              dataPoint.values = jsonEncode(map);
              yield dataPoint;
            }
          }

          // only one key with no list, which means we found a datapoint
          if (amountOfKeys == 1 && jsonObject is Map<String, dynamic>) {
            var dataMap = flatten(jsonObject);

            // create the generic datapoint
            var dataString = jsonEncode(dataMap);
            DataPoint dataPoint = DataPoint(values: dataString);

            dataPoint.valuesMap = dataMap;

            // we set the relation for dataPointName
            DataPointName dataPointName = DataPointName(name: _cleanName(key));
            dataPoint.dataPointName.target = dataPointName;

            yield dataPoint;
          }
        }
      }
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
      // _appLogger.logger.info(e);
    }
  }

  Future<dynamic> _getJson(File file) async {
    var json = await file.readAsString();
    return jsonDecode(json);
  }

  bool _isNumeric(String s) => double.tryParse(s) != null;

  // make special cases here for certain datapoints based on which directory they are in
  // for instance, the filename for facebook inbox, should be replaced by the name of the parent directory
  // TODO : use replaceAllMapped instead
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
