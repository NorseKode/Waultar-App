import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class DataPointRepository {
  final ObjectBox _context;
  late final Box<DataPoint> _dataBox;

  DataPointRepository(this._context) {
    _dataBox = _context.store.box<DataPoint>();
  }

  int addDataPoint(DataPoint dataPoint) => _dataBox.put(dataPoint);
  List<int> addMany(List<DataPoint> dataPoints) => _dataBox.putMany(dataPoints);
  List<DataPoint> readAll() => _dataBox.getAll();
  int count() => _dataBox.count();

  List<DataPoint> readAllFromCategory(DataCategory category) {
    var query =
        _dataBox.query(DataPoint_.category.equals(category.id)).build().find();
    return query;
  }

  List<UIDTO> search(String searchString, int offset, int limit) {
    var builder = _dataBox
        .query(DataPoint_.searchStrings
            .contains(searchString, caseSensitive: false))
        .build();
    builder
      ..offset = offset
      ..limit = limit;
    return builder.find().map((e) => e.getUIDTO).toList();
  }

  List<UIDTO> searchWithCategories(
      List<int> categorieIDs, String searchString, int offset, int limit) {
    var builder = _dataBox.query(
        DataPoint_.searchStrings.contains(searchString, caseSensitive: false));
    builder.link(DataPoint_.category, DataCategory_.id.oneOf(categorieIDs));

    var query = builder.build();
    query
      ..offset = offset
      ..limit = limit;

    return query.find().map((e) => e.getUIDTO).toList();
  }
}

class UIDTO implements UIModel {
  final String stringName;
  final DataCategory category;
  final Map<String, dynamic> dataMap;
  late Color associatedColor;
  late String mostInformativeField;
  late DateTime timeStamp;

  UIDTO(this.stringName, this.category, this.dataMap) {
    associatedColor = category.category.color;
  }

  @override
  Color getAssociatedColor() {
    return associatedColor;
  }

  @override
  String getMostInformativeField() {
    return 'MOST INFORMATIVE FIELD TEST';
  }

  @override
  DateTime? getTimestamp() {
    return null;
  }

  @override
  Map<String, dynamic> toMap() {
    return dataMap;
  }

  @override
  String toString() {
    return 'Dataname: $stringName \nData: \n${prettyJson(dataMap)}';
  }
}
