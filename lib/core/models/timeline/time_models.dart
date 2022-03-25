import 'package:tuple/tuple.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/models/ui_model.dart';

abstract class TimeModel {
  int id;
  int timeValue;
  int total;
  List<Tuple2<DataCategory, int>> categoryCount;
  List<Tuple2<ServiceDocument, int>> serviceCount;
  List<UIModel> dataPoints;

  TimeModel(this.id, this.timeValue, this.total, this.categoryCount,
      this.serviceCount, this.dataPoints);
}

class YearModel extends TimeModel {
  YearModel({
    required int id,
    required int year,
    required int total,
    required List<Tuple2<DataCategory, int>> categoryCount,
    required List<Tuple2<ServiceDocument, int>> serviceCount,
  }) : super(
          id,
          year,
          total,
          categoryCount,
          serviceCount,
          [],
        );
}

class MonthModel extends TimeModel {
  MonthModel({
    required int id,
    required int month,
    required int total,
    required List<Tuple2<DataCategory, int>> categoryCount,
    required List<Tuple2<ServiceDocument, int>> serviceCount,
  }) : super(
          id,
          month,
          total,
          categoryCount,
          serviceCount,
          [],
        );
}

class DayModel extends TimeModel {
  DayModel({
    required int id,
    required int day,
    required int total,
    required List<Tuple2<DataCategory, int>> categoryCount,
    required List<Tuple2<ServiceDocument, int>> serviceCount,
    required List<UIModel> dataPoints,
  }) : super(
          id,
          day,
          total,
          categoryCount,
          serviceCount,
          dataPoints,
        );
}

class HourModel extends TimeModel {
  HourModel({
    required int id,
    required int hour,
    required int total,
    required List<Tuple2<DataCategory, int>> categoryCount,
    required List<Tuple2<ServiceDocument, int>> serviceCount,
    required List<UIModel> dataPoints,
  }) : super(
          id,
          hour,
          total,
          categoryCount,
          serviceCount,
          dataPoints,
        );
}
