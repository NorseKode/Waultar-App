import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';

@Entity()
class YearBucket {
  int id;

  @Unique()
  int year;

  int total;

  String categoryCountMap;
  String serviceCountMap;

  final months = ToMany<MonthBucket>();

  YearBucket({
    this.id = 0,
    this.total = 0,
    required this.year,
    required this.categoryCountMap,
    required this.serviceCountMap,
  });
}

@Entity()
class MonthBucket {
  int id;
  int month;
  int total;

  String categoryCountMap;
  String serviceCountMap;

  final year = ToOne<YearBucket>();
  final days = ToMany<DayBucket>();

  MonthBucket({
    this.id = 0,
    this.total = 0,
    required this.month,
    required this.categoryCountMap,
    required this.serviceCountMap,
  });
}

@Entity()
class DayBucket {
  int id;
  int day;
  int total;

  String categoryCountMap;
  String serviceCountMap;

  final month = ToOne<MonthBucket>();
  final dataPoints = ToMany<DataPoint>();

  DayBucket({
    this.id = 0,
    this.total = 0,
    required this.day,
    required this.categoryCountMap,
    required this.serviceCountMap,
  });
}
