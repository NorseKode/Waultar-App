import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:pretty_json/pretty_json.dart';

@Entity()
class InodeRelationHolder {
  final int id;

  @Backlink('relation')
  final dataPoint = ToOne<InodeDataPoint>();

  @Backlink('relations')
  final images = ToMany<InodeImage>();
  @Backlink('relations')
  final persons = ToMany<InodePerson>();

  InodeRelationHolder({
    this.id = 0,
  });
}

@Entity()
class InodePerson {
  final int id;
  final String name;

  @Backlink('persons')
  final relations = ToMany<InodeRelationHolder>();

  InodePerson({
    this.id = 0,
    required this.name,
  });
}

@Entity()
class InodeImage {
  final int id;

  @Backlink('images')
  final relations = ToMany<InodeRelationHolder>();

  @Unique()
  final String uri;

  final String? meta;

  InodeImage({
    this.id = 0,
    required this.uri,
    this.meta,
  });
}

@Entity()
class InodeDataPoint {
  final int id;
  final dataPointName = ToOne<InodeDataPointName>();
  final dataCategory = ToOne<InodeDataCategory>();
  // final String name;

  final createdAt = ToOne<InodeTimeStamp>();
  final updatedAt = ToOne<InodeTimeStamp>();

  /// The raw data of the extracted dump stored in json
  List<String> keys;

  // TODO : consider having values map as seperate table
  // should reduce size, and give better performance when queryring
  // the raw data for full text search
  @Index()
  String? values;

  @Transient()
  Map<String, dynamic>? valuesMap;

  @Backlink('dataPoint')
  final timestamps = ToMany<InodeTimeStamp>();

  @Backlink('dataPoint')
  final relation = ToOne<InodeRelationHolder>();

  InodeDataPoint({
    this.id = 0,
    required this.keys,
    // required this.name,
  });

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write("\n");
    sb.write("-------------${runtimeType.toString()}-------------\n");
    sb.write("ID : $id \n");

    if (createdAt.hasValue) {
      sb.write("Created at : ${createdAt.target!.timeStamp.toString()}\n");
    }

    if (dataPointName.hasValue) {
      sb.write("DataPoint name : ${dataPointName.target!.name}\n");
    }

    sb.write("Data :\n");

    if (values != null) {
      var json = jsonDecode(values!);
      String pretty = prettyJson(json);
      sb.write(pretty);
      sb.write("\n");
    }

    sb.write("--------------------------\n");
    return sb.toString();
  }
}

@Entity()
class InodeDataPointName {
  final int id;

  @Index()
  final String name;

  @Backlink('dataPointNames')
  final dataCategory = ToOne<InodeDataCategory>();

  @Backlink('dataPointName')
  final dataPoints = ToMany<InodeDataPoint>();

  InodeDataPointName(
    this.name, {
    this.id = 0,
  });
}

@Entity()
class InodeTimeStamp {
  @Property(type: PropertyType.date)
  final DateTime timeStamp;

  @Backlink('timestamps')
  final dataPoint = ToMany<InodeDataPoint>();

  InodeTimeStamp(this.timeStamp);
}

@Entity()
class InodeDataCategory {
  final int id;

  @Index()
  final String name;

  @Backlink('dataCategory')
  final dataPointNames = ToMany<InodeDataPointName>();

  final nodes = ToMany<InodeDataPoint>();

  InodeDataCategory({this.id = 0, required this.name});
}

// @Entity()
// class InodeMap {
//   final int id;

//   // final String key;
//   final key = ToOne<InodeMapKey>();
//   final value = ToOne<InodeMapValue>();

//   // @Index()
//   // final String value;

//   InodeMap({
//     this.id = 0,
//   });
// }

// @Entity()
// class InodeMapKey {
//   final int id;
//   final String key;

//   InodeMapKey(this.id, this.key);
// }

// @Entity()
// class InodeMapValue {
//   final int id;
//   final String value;

//   InodeMapValue(this.id, this.value);
// }

// class InodeParser {
//   // final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

//   Stream<dynamic> parseFile(File file, ServiceModel service) async* {
//     try {
//       // var json = await ParseHelper.getJsonStringFromFile(file);
//       var fileName = path_dart.basename(file.path);

//       if (fileName.endsWith('.json')) {
//         // ignore: avoid_print
//         print(fileName);
//       }

//       var jsonString = await file.readAsString();
//       var decodedJson = jsonDecode(jsonString);

//       // var postFilenameRegex = RegExp(r"your_posts_\d+");
//       // var matchedFile = postFilenameRegex.firstMatch(fileName);

//       await for (final item in ParseHelper.returnEveryJsonObject(decodedJson)) {
//         // create map <String, dynamic> and clean the incoming json
//         // and flatten when meating certain keys
//         if (item is Map<String, dynamic>) {
//           // if keys has at least on item, we need to parse either one datapoint
//           // or a series of data points depending on the type of the value
//           if (item.keys.isNotEmpty) {
//             int amountOfKeys = item.keys.length;
//             // only one key, which means we found a datapoint

//             if (amountOfKeys == 1) {
//               String key = item[item.keys.first];
//               var jsonObject = item[key];

//               InodeDataPointName dataPointName = InodeDataPointName(key);

//               InodeDataPoint dataPoint = InodeDataPoint();
//               dataPoint.createdAt.target = InodeTimeStamp(DateTime.now());
//               dataPoint.dataPointName.target = dataPointName;

//               if (jsonObject is Map<String, dynamic>) {
//                 var entries = jsonObject.entries;
//                 for (var item in entries) {
//                   dataPoint.keys.add(item.key);
//                   dataPoint.values = jsonEncode(item);

//                   if (item.value is DateTime) {
//                     InodeTimeStamp timestamp = InodeTimeStamp(item.value);
//                     dataPoint.timestamps.add(timestamp);
//                   }
//                 }
//               }

//               yield dataPoint;
//             }

//             // if (amountOfKeys > 1) {}

//             // switch (item.keys.first) {
//             //   case 'profile_v2':
//             //     var json = item['profile_v2'];
//             //     if (json is Map<String, dynamic>) {}

//             //     break;
//             //   default:
//             // }
//           }
//         }

//         if (item is List<dynamic>) {
//           print(item.first);
//         }
//       }
//     } on Exception catch (e) {
//       print(e);
//       // _appLogger.logger.info(e);
//     }
//   }
// }
