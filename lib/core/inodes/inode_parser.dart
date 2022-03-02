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

  Stream<dynamic> parseFile(File file) async* {
    try {
      // var json = await ParseHelper.getJsonStringFromFile(file);
      var fileName = path_dart.basename(file.path);

      if (fileName.endsWith('.json')) {
        // ignore: avoid_print
        fileName = fileName.replaceAll(".json", "");
        print(fileName);
      }

      // TODO : replace corrupted characters in json with correct unicode ..

      var json = await file.readAsString();
      var item = jsonDecode(json);

      // var postFilenameRegex = RegExp(r"your_posts_\d+");
      // var matchedFile = postFilenameRegex.firstMatch(fileName);

      // await for (final item in ParseHelper.returnEveryJsonObject(decodedJson)) {

      if (item is List<dynamic>) {
        DataPointName name = DataPointName(name: fileName);
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

            // we get the jsonobject bound to the key of the datapoint
            var jsonObject = item[key];

            // we set the relation for dataPointName
            DataPointName dataPointName = DataPointName(name: key);

            // create the generic datapoint
            DataPoint dataPoint = DataPoint(values: "");

            dataPoint.dataPointName.target = dataPointName;

            if (jsonObject is Map<String, dynamic>) {
              var entries = jsonObject.entries;

              // we are now at a attribute for the given data point
              // we save the attributes to a Map<String, dynamic> in the data point
              dataPoint.valuesMap = jsonObject;

              for (var item in entries) {
                // maintain a List<String> of the attribute name (it's metadata/key)
                String key = item.key;
                var value = item.value;

                if (value is List<dynamic>) {
                  var count = value.length;

                  if (count == 0) {
                    var map = {key: "no data"};
                    dataPoint.valuesMap!.addAll(map);
                  }

                  if (count >= 1) {
                    var map = {key: value};
                    dataPoint.valuesMap!.addAll(map);
                  }
                }

                dataPoint.values = jsonEncode(dataPoint.valuesMap);

                if (item.value is DateTime) {
                  dataPoint.timestamp = item.value;
                }
              }
            }

            yield dataPoint;
          }
        }
      }
      // }
    } on Exception catch (e) {
      print(e);
      // _appLogger.logger.info(e);
    }
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
          updated.addAll(flattenedInner);
        }

        acc = updated;
      }
    }

    if (keyState.isEmpty) {
      return acc;
    }

    // if the acc is neither a list or map, we reached a leaf
    // e.g. we either reached null, datetime, number or string
    return {keyState: acc};
  }

  Map<String, dynamic> flatten(dynamic json, {String nameToFallBackOn = ""}) {
    var result = _flattenRecurse(nameToFallBackOn, json);
    return result;
  }

  // void _generateRelations(
  //     InodeDataPoint dataPoint, List<String> relationsToLookFor) {
  //   final relationEntity = InodeRelationHolder();
  //   var map = dataPoint.valuesMap;

  //   if (map != null) {
  //     var json = jsonEncode(map);

  //     for (var match in relationsToLookFor) {
  //       String? obj = key_picker.pick(json, match).asStringOrNull();

  //       if (obj != null) {
  //         _makeRelation(obj, match, relationEntity);
  //       }
  //     }
  //   }

  //   dataPoint.relation.target = relationEntity;
  // }

  // void _makeRelation(
  //     String json, String relationType, InodeRelationHolder relationEntity) {
  //   switch (relationType) {
  //     case 'media':
  //       String uri = key_picker.pick(json, 'uri').asStringOrThrow();
  //       var image = InodeImage(uri: uri);
  //       relationEntity.images.add(image);
  //       break;

  //     default:
  //   }
  // }

  void _removeRelationsFromRaw(DataPoint dataPoint) {}
}
