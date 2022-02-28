import 'dart:convert';
import 'dart:io';

import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

import 'package:path/path.dart' as path_dart;
import 'package:deep_pick/deep_pick.dart' as key_picker;

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
        print(fileName);
      }

      // TODO : replace corrupted characters in json with correct unicode ..

      var json = await file.readAsString();
      var decodedJson = jsonDecode(json);

      // var postFilenameRegex = RegExp(r"your_posts_\d+");
      // var matchedFile = postFilenameRegex.firstMatch(fileName);

      await for (final item in ParseHelper.returnEveryJsonObject(decodedJson)) {
        // create map <String, dynamic> and clean the incoming json
        // and flatten when meating certain keys
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
              InodeDataPointName dataPointName = InodeDataPointName(key);

              // create the generic datapoint
              InodeDataPoint dataPoint = InodeDataPoint(keys: []);

              // This should be done in the data layer
              // useful for us to check when a given datapoint was parsed for the first time
              dataPoint.createdAt.target = InodeTimeStamp(DateTime.now());
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
                  dataPoint.keys.add(key);

                  //

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
                    InodeTimeStamp timestamp = InodeTimeStamp(item.value);
                    dataPoint.timestamps.add(timestamp);
                  }
                }
              }

              // ignore: avoid_print
              // print(dataPoint.toString());

              yield dataPoint;
            }
          }
        }

        if (item is List<dynamic>) {
          print(item.first);
        }
      }
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
        // if (type is List<dynamic>) {
        //   acc.first = _flattenRecurse("", acc.first);
        // } else if (type is Map<String, dynamic>) {
        //   // var entries = type.entries;
        //   // for (var item in entries) {
        //   //   return _flattenRecurse(keyState, acc);
        //   // }
        //   if (type.length == 1) {
        //     var key = type.entries.first.key;
        //     var value = type.entries.first.value;
        //     return _flattenRecurse(key, value);
        //   } else if (type.length > 1) {
        //     print(type.length);
        //   }

        // } else {
        //   return {keyState: acc.first};
        // }
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
        var toRemove = [];
        var toReplace = [];

        for (var item in entries) {
          var key = item.key;
          var value = item.value;

          toRemove.add(key);
          toReplace.add(_flattenRecurse(key, value));
        }

        for (var i = 0; i < toRemove.length; i++) {
          acc.remove(toRemove[i]);
          acc.addAll(toReplace[i]);
        }
        
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

  void _generateRelations(
      InodeDataPoint dataPoint, List<String> relationsToLookFor) {
    final relationEntity = InodeRelationHolder();
    var map = dataPoint.valuesMap;

    if (map != null) {
      var json = jsonEncode(map);

      for (var match in relationsToLookFor) {
        String? obj = key_picker.pick(json, match).asStringOrNull();

        if (obj != null) {
          _makeRelation(obj, match, relationEntity);
        }
      }
    }

    dataPoint.relation.target = relationEntity;
  }

  void _makeRelation(
      String json, String relationType, InodeRelationHolder relationEntity) {
    switch (relationType) {
      case 'media':
        String uri = key_picker.pick(json, 'uri').asStringOrThrow();
        var image = InodeImage(uri: uri);
        relationEntity.images.add(image);
        break;

      default:
    }
  }

  void _removeRelationsFromRaw(InodeDataPoint dataPoint) {}
}
