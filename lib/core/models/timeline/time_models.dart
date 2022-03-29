import 'package:tuple/tuple.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';

abstract class TimeModel {
  int id;
  int timeValue; // x value
  int total; // y total value
  List<Tuple2<DataCategory, int>> categoryCount;
  List<Tuple2<ProfileDocument, int>> profileCount;
  List<UIModel> dataPoints;

  TimeModel(this.id, this.timeValue, this.total, this.categoryCount,
      this.profileCount, this.dataPoints);
}

class YearModel extends TimeModel {
  YearModel({
    required int id,
    required int year,
    required int total,
    required List<Tuple2<DataCategory, int>> categoryCount,
    required List<Tuple2<ProfileDocument, int>> profileCount,
  }) : super(
          id,
          year,
          total,
          categoryCount,
          profileCount,
          [],
        );
}

class MonthModel extends TimeModel {
  MonthModel({
    required int id,
    required int month,
    required int total,
    required List<Tuple2<DataCategory, int>> categoryCount,
    required List<Tuple2<ProfileDocument, int>> profileCount,
  }) : super(
          id,
          month,
          total,
          categoryCount,
          profileCount,
          [],
        );
}

class DayModel extends TimeModel {
  DayModel({
    required int id,
    required int day,
    required int total,
    required List<Tuple2<DataCategory, int>> categoryCount,
    required List<Tuple2<ProfileDocument, int>> profileCount,
    required List<UIModel> dataPoints,
  }) : super(
          id,
          day,
          total,
          categoryCount,
          profileCount,
          dataPoints,
        );
}

class HourModel extends TimeModel {
  HourModel({
    required int id,
    required int hour,
    required int total,
    required List<Tuple2<DataCategory, int>> categoryCount,
    required List<Tuple2<ProfileDocument, int>> profileCount,
    required List<UIModel> dataPoints,
  }) : super(
          id,
          hour,
          total,
          categoryCount,
          profileCount,
          dataPoints,
        );
}
