import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:pretty_json/pretty_json.dart';

// @Entity()
// class InodeRelationHolder {
//   final int id;

//   @Backlink('relation')
//   final dataPoint = ToOne<DataPoint>();

//   @Backlink('relations')
//   final images = ToMany<InodeImage>();
//   @Backlink('relations')
//   final persons = ToMany<InodePerson>();

//   InodeRelationHolder({
//     this.id = 0,
//   });
// }

// @Entity()
// class InodePerson {
//   final int id;
//   final String name;

//   @Backlink('persons')
//   final relations = ToMany<InodeRelationHolder>();

//   InodePerson({
//     this.id = 0,
//     required this.name,
//   });
// }

// @Entity()
// class InodeImage {
//   final int id;

//   @Backlink('images')
//   final relations = ToMany<InodeRelationHolder>();

//   @Unique()
//   final String uri;

//   final String? meta;

//   InodeImage({
//     this.id = 0,
//     required this.uri,
//     this.meta,
//   });
// }

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

    // var json = jsonDecode(values);
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

  @Index()
  String name;

  final dataCategory = ToOne<DataCategory>();

  @Backlink('dataPointName')
  final dataPoints = ToMany<DataPoint>();

  DataPointName(
    this.name, {
    this.id = 0,
  });
}

@Entity()
class DataCategory {
  int id;

  @Index()
  String name;

  @Backlink('dataCategory')
  final dataPointNames = ToMany<DataPointName>();

  // final nodes = ToMany<DataPoint>();

  DataCategory({this.id = 0, required this.name});
}
