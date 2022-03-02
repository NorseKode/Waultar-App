import 'dart:convert';
import 'dart:io';

import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

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
  }
}

class InodeParser {
  // final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  Future<dynamic> getJson(File file) async {
    var json = await file.readAsString();
    return jsonDecode(json);
  }

  bool isNumeric(String s) => double.tryParse(s) != null;

  // make special cases here for certain datapoints based on which directory they are in
  // for instance, the filename for facebook inbox, should be replaced by the name of the parent directory
  String cleanFileName(String filename) {
    return filename.split("_").fold(
        "",
        (previousValue, element) => isNumeric(element)
            ? previousValue + " "
            : previousValue + element + " ");
  }

  Stream<dynamic> parseFile(File file) async* {
    try {
      var fileName = path_dart.basename(file.path);
      if (fileName.endsWith('.json')) {
        fileName = fileName.replaceAll(".json", "");
      }


      // TODO : replace corrupted characters in json with correct unicode ..
      // æ, ø, å and emojeys are corrupted
      // this is an error from facebook - they do not send the json in correct utf8 format ..

      var json = await file.readAsString();
      var item = jsonDecode(json);

      // var postFilenameRegex = RegExp(r"your_posts_\d+");
      // var matchedFile = postFilenameRegex.firstMatch(fileName);


      if (item is List<dynamic>) {
        DataPointName name = DataPointName(name: cleanFileName(fileName));
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
          // only one key, which means we found a datapoint

          if (amountOfKeys == 1) {

            // we have a datapoint and we save the key as the name for the data point
            String key = item.keys.first;
            var jsonObject = item[key];
            var dataMap = flatten(jsonObject);

            // create the generic datapoint
            var dataString = jsonEncode(dataMap);
            DataPoint dataPoint = DataPoint(values: dataString);

            dataPoint.valuesMap = dataMap;

            // we set the relation for dataPointName
            DataPointName dataPointName = DataPointName(name: key);
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

          // the recursive call might return a key already existing in the updated map
          // if that is the case, put the returned value with the old key
          if (updated.containsKey(flattenedInner.entries.first.key)) {
            if (!updated.containsKey(key)) {
              updated.addAll({key: flattenedInner.entries.first.value});
            } else {
              updated.addAll({keyState: flattenedInner.entries.first.value});
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