import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:pretty_json/pretty_json.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs

@Entity()
class DataPoint {
  int id;
  final dataPointName = ToOne<DataPointName>();
  late String stringName;

  final category = ToOne<DataCategory>();

  @Index()
  late String searchString;

  // make these seracheable or traversable
  // late List<String> keys;

  late String values;

  @Transient()
  late Map<String, dynamic> valuesMap;

  DataPoint({
    this.id = 0,
  });

  Map<String, dynamic> get asMap {
    var decoded = jsonDecode(values);
    if (decoded is List<dynamic>) {
      return {'values':decoded};
    } else {
      return decoded;
    }
  }

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write("\n");
    sb.write("############# DataPoint #############\n");
    sb.write("ID: $id \n");

    if (dataPointName.hasValue) {
      sb.write("DataPoint relation target name: ${dataPointName.target!.name}\n");
    }

    sb.write("Embedded datapoint name: $stringName\n");

    sb.write("Data:\n");

    if (values.isNotEmpty) {
      String pretty = prettyJson(jsonDecode(values));
      sb.write(pretty);
    } 
    sb.write("\n");

    sb.write("#####################################\n");
    return sb.toString();
  }
}

@Entity()
class DataPointName {
  int id;
  int count;

  @Index()
  String name;

  final dataCategory = ToOne<DataCategory>();

  @Backlink('dataPointName')
  final dataPoints = ToMany<DataPoint>();

  final children = ToMany<DataPointName>();
  final parent = ToOne<DataPointName>();

  DataPointName({
    this.id = 0,
    this.count = 0,
    required this.name,
  });
}

@Entity()
class DataCategory {
  int id;

  int count;

  List<String> matchingFolders;

  @Index()
  @Unique()
  String name;

  @Backlink('dataCategory')
  final dataPointNames = ToMany<DataPointName>();

  DataCategory({
    this.id = 0,
    this.count = 0,
    required this.name,
    required this.matchingFolders,
  });
}
