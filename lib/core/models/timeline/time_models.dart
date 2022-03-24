import 'package:tuple/tuple.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';

abstract class TimeModel {
  int id;
  int timeValue;
  int total;
  List<Tuple2<DataCategory, int>> categoryCount;
  List<Tuple2<ServiceDocument, int>> serviceCount;

  TimeModel(
    this.id,
    this.timeValue,
    this.total,
    this.categoryCount,
    this.serviceCount,
  );
}

class YearModel extends TimeModel {
  YearModel(
    int id,
    int year,
    int total,
    List<Tuple2<DataCategory, int>> categoryCount,
    List<Tuple2<ServiceDocument, int>> serviceCount,
  ) : super(
          id,
          year,
          total,
          categoryCount,
          serviceCount,
        );
}

class MonthModel extends TimeModel {
  MonthModel(
    int id,
    int month,
    int total,
    List<Tuple2<DataCategory, int>> categoryCount,
    List<Tuple2<ServiceDocument, int>> serviceCount,
  ) : super(
          id,
          month,
          total,
          categoryCount,
          serviceCount,
        );
}

class DayModel extends TimeModel {
  List<DataPoint> dataPoints;
  DayModel(
    int id,
    int day,
    int total,
    List<Tuple2<DataCategory, int>> categoryCount,
    List<Tuple2<ServiceDocument, int>> serviceCount,
    this.dataPoints,
  ) : super(
          id,
          day,
          total,
          categoryCount,
          serviceCount,
        );
}
