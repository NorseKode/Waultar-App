import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';

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

  List<UIDTO> search(
      List<int> categoryIds, String searchString, int offset, int limit) {
    var builder = _dataBox.query(
      DataPoint_.searchTerms.contains(
        searchString,
        caseSensitive: false,
      ),
    );
    builder.link(
      DataPoint_.category,
      DataCategory_.dbCategory.oneOf(categoryIds),
    );
    var query = builder.build();

    query
      ..offset = offset
      ..limit = limit;
    return query.find().map((e) => e.getUIDTO).toList();
  }

  int readAllSentimentCategory(int categoryId) {
    var query = _dataBox
        .query(DataPoint_.category
            .equals(categoryId)
            .and(DataPoint_.sentimentText.notNull())
            .and(DataPoint_.sentimentText.notEquals(""))
            .and(DataPoint_.sentimentScore.isNull()))
        .build()
        .count();
    return query;
  }
}

class UIDTO implements UIModel {
  final DataPoint dataPoint;
  late Color associatedColor;
  late String mostInformativeField;
  late DateTime timeStamp;
  late String path;

  UIDTO({required this.dataPoint}) {
    associatedColor = dataPoint.category.target!.category.color;
    path = dataPoint.path;
  }

  @override
  Color getAssociatedColor() {
    return associatedColor;
  }

  @override
  String getMostInformativeField() {
    return dataPoint.stringName;
  }

  @override
  DateTime? getTimestamp() {
    return null;
  }

  @override
  Map<String, dynamic> toMap() {
    return dataPoint.asMap;
  }

  @override
  String toString() {
    return 'Path: $path \n${prettyJson(dataPoint.asMap)}';
  }
}
