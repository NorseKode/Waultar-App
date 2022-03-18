import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';

@Entity()
class YearBucket {
  int id;

  @Unique()
  int year;

  int total;

  String stringMap;

  final months = ToMany<MonthBucket>();

  YearBucket(
      {this.id = 0,
      this.total = 0,
      required this.year,
      required this.stringMap});
}

@Entity()
class MonthBucket {
  int id;
  int month;
  int total;

  String stringMap;

  final year = ToOne<YearBucket>();
  final days = ToMany<DayBucket>();

  MonthBucket(
      {this.id = 0,
      this.total = 0,
      required this.month,
      required this.stringMap});
}

@Entity()
class DayBucket {
  int id;
  int day;
  int total;

  String stringMap;

  final month = ToOne<MonthBucket>();

  final posts = ToMany<PostObjectBox>();
  final groups = ToMany<GroupObjectBox>();
  final events = ToMany<EventObjectBox>();

  DayBucket(
      {this.id = 0,
      this.total = 0,
      required this.day,
      required this.stringMap});
}