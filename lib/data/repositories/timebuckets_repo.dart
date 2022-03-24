import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_timebuckets_repository.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/timebuckets/buckets.dart';

class TimeBucketsRepository implements ITimeBucketsRepository {
  late final ObjectBox _context;
  late final Box<YearBucket> _yearBox;
  late final Box<MonthBucket> _monthBox;
  late final Box<DayBucket> _dayBox;
  late final Box<DataPoint> _dataBox;

  TimeBucketsRepository(this._context) {
    _yearBox = _context.store.box<YearBucket>();
    _monthBox = _context.store.box<MonthBucket>();
    _dayBox = _context.store.box<DayBucket>();
    _dataBox = _context.store.box<DataPoint>();
  }

  @override
  List<DataPoint> getAllDataPointsFromDay(DayModel day) {
    // TODO: implement getAllDataPointsFromDay
    throw UnimplementedError();
  }

  @override
  List<DayModel> getAllDaysFromMonth(MonthModel month) {
    // TODO: implement getAllDaysFromMonth
    throw UnimplementedError();
  }

  @override
  List<MonthModel> getAllMonthsFromYear(YearModel year) {
    // TODO: implement getAllMonthsFromYear
    throw UnimplementedError();
  }

  @override
  List<UIModel> getAllUIModelsFromDay(DayModel day) {
    // TODO: implement getAllUIModelsFromDay
    throw UnimplementedError();
  }

  @override
  List<YearModel> getAllYears() {
    // TODO: implement getAllYears
    throw UnimplementedError();
  }

  @override
  void generateBuckets() {
    // var dataPointsWithTimestamps = _dataBox
    //     .query(DataPoint_.hasBeenBucketProcessed
    //         .equals(false)
    //         .and(DataPoint_.timestamps.greaterThan([0])))
    //     .build()
    //     .find();

    // for (var dataPoint in dataPointsWithTimestamps) {
    //   for (var timestamp in dataPoint.timestamps) {
    //     var datetime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    //     var tuple = _dissectDateTime(datetime);
    //   }
    // }
  }

  Tuple3<int, int, int> _dissectDateTime(DateTime timestamp) {
    int year = timestamp.year;
    int month = timestamp.month;
    int day = timestamp.day;
    return Tuple3(year, month, day);
  }
}
