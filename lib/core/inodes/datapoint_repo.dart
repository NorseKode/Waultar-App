import 'dart:ui';

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
  List<DataPoint> search(String searchString, int offset, int limit) {
    var builder = _dataBox
        .query(DataPoint_.searchString
            .contains(searchString, caseSensitive: false))
        .build();
    builder
      ..offset = offset
      ..limit = limit;
    return builder.find();
  }
}

class UIDTO implements UIModel {

  final String stringName;
  final DataCategory category;
  final Map<String, dynamic> dataMap;
  
  @override
  Color getAssociatedColor() {
    // TODO: implement getAssociatedColor
    throw UnimplementedError();
  }

  @override
  String getMostInformativeField() {
    // TODO: implement getMostInformativeField
    throw UnimplementedError();
  }

  @override
  DateTime getTimestamp() {
    // TODO: implement getTimestamp
    throw UnimplementedError();
  }

  @override
  Map<String, String> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}
