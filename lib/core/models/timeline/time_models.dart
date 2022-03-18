import 'dart:ui';
import 'package:tuple/tuple.dart';

abstract class TimeModel {
  int id;
  int timeValue;
  int total;
  List<Tuple3<int, String, Color>> entries;

  TimeModel(this.id, this.timeValue, this.total, this.entries);
}

class YearModel extends TimeModel {
  YearModel(
      int id, int year, int total, List<Tuple3<int, String, Color>> entries)
      : super(id, year, total, entries);
}

class MonthModel extends TimeModel {
  MonthModel(
      int id, int month, int total, List<Tuple3<int, String, Color>> entries)
      : super(id, month, total, entries);
}

class DayModel extends TimeModel {
  DayModel(int id, int day, int total, List<Tuple3<int, String, Color>> entries)
      : super(id, day, total, entries);
}
