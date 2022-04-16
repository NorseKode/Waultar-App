import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';

abstract class TimeModel {
  ProfileDocument profile;
  int id;
  int timeValue; // x value
  int total; // y total value
  DateTime dateTime;
  List<Tuple2<CategoryEnum, int>> categoryCount;
  List<Tuple2<CategoryEnum, double>> sentimentScores;

  TimeModel(
    this.profile,
    this.id,
    this.timeValue,
    this.total,
    this.dateTime,
    this.categoryCount,
    this.sentimentScores,
  );
}

class YearModel extends TimeModel {
  YearModel({
    required ProfileDocument profile,
    required int id,
    required int year,
    required int total,
    required DateTime dateTime,
    required List<Tuple2<CategoryEnum, int>> categoryCount,
    required List<Tuple2<CategoryEnum, double>> sentimentScores,
  }) : super(
          profile,
          id,
          year,
          total,
          dateTime,
          categoryCount,
          sentimentScores,
        );
}

class MonthModel extends TimeModel {
  MonthModel({
    required ProfileDocument profile,
    required int id,
    required int month,
    required int total,
    required DateTime dateTime,
    required List<Tuple2<CategoryEnum, int>> categoryCount,
    required List<Tuple2<CategoryEnum, double>> sentimentScores,
  }) : super(
          profile,
          id,
          month,
          total,
          dateTime,
          categoryCount,
          sentimentScores,
        );
}

class DayModel extends TimeModel {
  DayModel({
    required ProfileDocument profile,
    required int id,
    required int day,
    required int total,
    required DateTime dateTime,
    required List<Tuple2<CategoryEnum, int>> categoryCount,
    required List<Tuple2<CategoryEnum, double>> sentimentScores,
  }) : super(
          profile,
          id,
          day,
          total,
          dateTime,
          categoryCount,
          sentimentScores,
        );
}

class HourModel extends TimeModel {
  HourModel({
    required ProfileDocument profile,
    required int id,
    required int hour,
    required int total,
    required DateTime dateTime,
    required List<Tuple2<CategoryEnum, int>> categoryCount,
    required List<Tuple2<CategoryEnum, double>> sentimentScores,
  }) : super(
          profile,
          id,
          hour,
          total,
          dateTime,
          categoryCount,
          sentimentScores,
        );
}
