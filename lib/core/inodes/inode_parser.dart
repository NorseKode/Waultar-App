import 'dart:convert';
import 'dart:io';

import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

import 'package:path/path.dart' as path_dart;

class InodeParser {
  // final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  Stream<dynamic> parseFile(File file) async* {
    try {
      // var json = await ParseHelper.getJsonStringFromFile(file);
      var fileName = path_dart.basename(file.path);

      if (fileName.endsWith('.json')) {
        // ignore: avoid_print
        print(fileName);
      }

      var jsonString = await file.readAsString();
      var decodedJson = jsonDecode(jsonString);

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
              String key = item.keys.first;
              var jsonObject = item[key];

              InodeDataPointName dataPointName = InodeDataPointName(key);

              InodeDataPoint dataPoint = InodeDataPoint(keys: []);
              dataPoint.createdAt.target = InodeTimeStamp(DateTime.now());
              dataPoint.dataPointName.target = dataPointName;

              if (jsonObject is Map<String, dynamic>) {
                var entries = jsonObject.entries;
                dataPoint.valuesMap = jsonObject;
                for (var item in entries) {
                  dataPoint.keys.add(item.key);
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

            // if (amountOfKeys > 1) {}

            // switch (item.keys.first) {
            //   case 'profile_v2':
            //     var json = item['profile_v2'];
            //     if (json is Map<String, dynamic>) {}

            //     break;
            //   default:
            // }
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
}