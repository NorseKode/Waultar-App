import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:pretty_json/pretty_json.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs

@Entity()
class DataPoint {
  int id;
  final dataPointName = ToOne<DataPointName>();

  // make these seracheable or traversable
  // late List<String> keys;

  // put theses in some other collection perhaps ?
  @Index()
  String values;

  final children = ToMany<DataPoint>();

  @Transient()
  late Map<String, dynamic> valuesMap;

  @Index()
  @Property(type: PropertyType.date)
  DateTime? timestamp;

  DataPoint({
    this.id = 0,
    required this.values,
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
    sb.write("ID : $id \n");

    if (timestamp != null) {
      sb.write("Timestamp : ${timestamp.toString()}\n");
    }

    if (dataPointName.hasValue) {
      sb.write("DataPoint name : ${dataPointName.target!.name}\n");
    }

    sb.write("Data :\n");

    if (values.isNotEmpty) {
      String pretty = prettyJson(jsonDecode(values));
      sb.write(pretty);
    } else {
      sb.write("No data in me - I'm merely a directory containing children");
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

  // this enables us to create folders
  // is this property is not empty, it means that, there are nested datapoints
  final dataPointNames = ToMany<DataPointName>();

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

  // final dataPointDirs = ToMany<DataPointDir>();

  DataCategory({
    this.id = 0,
    this.count = 0,
    required this.name,
    required this.matchingFolders,
  });
}
