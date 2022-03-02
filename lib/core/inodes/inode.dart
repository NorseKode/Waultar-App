import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:pretty_json/pretty_json.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs

@Entity()
class DataPoint {
  int id;
  final dataPointName = ToOne<DataPointName>();

  @Index()
  String values;

  @Transient()
  Map<String, dynamic>? valuesMap;

  @Index()
  @Property(type: PropertyType.date)
  DateTime? timestamp;

  DataPoint({
    this.id = 0,
    required this.values,
  });

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write("\n");
    sb.write("-------------${runtimeType.toString()}-------------\n");
    sb.write("ID : $id \n");

    if (timestamp != null) {
      sb.write("Created at : ${timestamp.toString()}\n");
    }

    if (dataPointName.hasValue) {
      sb.write("DataPoint name : ${dataPointName.target!.name}\n");
    }

    sb.write("Data :\n");

    String pretty = prettyJson(valuesMap);
    sb.write(pretty);
    sb.write("\n");

    sb.write("--------------------------\n");
    return sb.toString();
  }
}

@Entity()
class DataPointName {
  int id;
  int count;

  @Unique()
  @Index()
  String name;

  final dataCategory = ToOne<DataCategory>();

  @Backlink('dataPointName')
  final dataPoints = ToMany<DataPoint>();

  DataPointName({
    this.id = 0,
    this.count = 0,
    required this.name,
  });
}

@Entity()
class DataPointDir {
  int id;
  int count;

  String name;

  final dataPointNames = ToMany<DataPointName>();
  final dataPointDirs = ToMany<DataPointDir>();

  DataPointDir({
    this.id = 0,
    this.count = 0,
    required this.name,
  });
}

@Entity()
class DataCategory {
  int id;

  int count;

  @Index()
  @Unique()
  String name;

  @Backlink('dataCategory')
  final dataPointNames = ToMany<DataPointName>();

  final dataPointDirs = ToMany<DataPointDir>();

  DataCategory({
    this.id = 0,
    this.count = 0,
    required this.name,
  });
}
