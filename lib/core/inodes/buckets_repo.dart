// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:tuple/tuple.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/timebuckets/buckets.dart';

abstract class IBucketsRepository {
  Future createBuckets(DateTime dataPointsCreatedAfter);
  List<YearBucket> getAllYears();
  YearBucket? getYear(int year);
  List<MonthBucket> getMonthsFromYearValue(int year);
  List<MonthBucket> getMonthsFromYearId(int yearId);
  List<DayBucket> getDaysFromMonth(MonthBucket month);
  List<DayBucket> getDaysFromMonthId(int monthId);
}

class IRepository {
  /*
  T get(int id);
  */
}

class BucketsRepository extends IBucketsRepository {
  final ObjectBox _context;
  late final Box<YearBucket> _yearBox;
  late final Box<MonthBucket> _monthBox;
  late final Box<DayBucket> _dayBox;

  BucketsRepository(this._context) {
    _yearBox = _context.store.box<YearBucket>();
    _monthBox = _context.store.box<MonthBucket>();
    _dayBox = _context.store.box<DayBucket>();
  }

  @override
  Future createBuckets(DateTime dataPointsCreatedAfter) async {
    var createdSince = dataPointsCreatedAfter.microsecondsSinceEpoch;

    var years = _yearBox.getAll();

    // streams all datapoints that have been created after createdSince
    var toBeProcessed = _context.store
        .box<DataPoint>()
        .query(DataPoint_.dbCreatedAt.greaterThan(createdSince))
        .build()
        .stream();

    // process each datapoint from the stream
    await for (var dataPoint in toBeProcessed) {
      var timestamps = _scrapeUniqueTimestamps(dataPoint);

      if (timestamps.isNotEmpty) {
        int categoryId = dataPoint.category.targetId;
        int serviceId = dataPoint.service.targetId;

        for (var timestamp in timestamps) {
          var dissected = _dissectDateTime(timestamp);

          // the values lie in the tuple
          int year = dissected.item1;
          int month = dissected.item2;
          int day = dissected.item3;
          int hour = dissected.item4;

          bool yearExists = years.any((element) => element.year == year);
          if (yearExists) {
            
            var yearBucket = years.singleWhere((element) => element.year == year);
            var categoryMap = yearBucket.categoryMap;

          } else {

            // if the year is not present we have to create a new bucket for each time entity
            var yearBucket = YearBucket(year: year, total: 1);
            yearBucket.categoryMap = {categoryId: 1};
            yearBucket.serviceMap = {serviceId: 1};
            var monthBucket = MonthBucket(month: month, categoryCountMap: '{"$categoryId":${1.toString()}}', serviceCountMap: '{"$serviceId":${1.toString()}}', total: 1);
            var dayBucket = DayBucket(day: day, categoryCountMap: '{"$categoryId":${1.toString()}}', serviceCountMap: '{"$serviceId":${1.toString()}}', total: 1);
            dayBucket.dataPoints.add(dataPoint);
            monthBucket.days.add(dayBucket);
            yearBucket.months.add(monthBucket);
            years.add(yearBucket);
          }
          
        }
      }
    }

    // when the stream has processed each element we update all the buckets via the root bucket in a single transaction
    _yearBox.putMany(years);
  }

  List<DateTime> _scrapeUniqueTimestamps(DataPoint dataPoint) {
    var timestampsSet = <DateTime>{};
    aux(dynamic data) {
      if (data is Map<String, dynamic>) {
        for (var value in data.values) {
          aux(value);
        }
      }
      if (data is List<dynamic>) {
        for (var item in data) {
          aux(item);
        }
      }
      if (data is int || data is String) {
        var timestamp = tryParse(data);
        if (timestamp != null) timestampsSet.add(timestamp);
      }
    }

    aux(dataPoint.asMap);
    return timestampsSet.toList();
  }

  DateTime? tryParse(dynamic value) {
    if (value is int) {
      if (value <= 0) return null;

      var length = '$value'.length;
      if (length >= 10 && length < 12) // <== seconds
        return DateTime.fromMillisecondsSinceEpoch(value * 1000);

      if (length >= 12 && length < 15) // <== milliseconds
        return DateTime.fromMillisecondsSinceEpoch(value);

      if (length >= 15 && length < 23) // <== microseconds and nano
        return DateTime.fromMicrosecondsSinceEpoch(value);
    }

    if (value is String) {
      if (value.isEmpty) return null;
      return DateTime.tryParse(value);
    }

    return null;
  }

  Tuple4<int, int, int, int> _dissectDateTime(DateTime timestamp) {
    int year = timestamp.year;
    int month = timestamp.month;
    int day = timestamp.day;
    int hour = timestamp.hour;
    return Tuple4(year, month, day, hour);
  }

  @override
  List<YearBucket> getAllYears() {
    return _yearBox.getAll();
  }

  @override
  List<DayBucket> getDaysFromMonth(MonthBucket month) {
    var bucket = _monthBox.get(month.id);
    return bucket == null ? [] : bucket.days;
  }

  @override
  List<DayBucket> getDaysFromMonthId(int monthId) {
    var bucket = _monthBox.get(monthId);
    return bucket == null ? [] : bucket.days;
  }

  @override
  List<MonthBucket> getMonthsFromYearId(int yearId) {
    var bucket = _yearBox.get(yearId);
    return bucket == null ? [] : bucket.months;
  }

  @override
  List<MonthBucket> getMonthsFromYearValue(int year) {
    var bucket =
        _yearBox.query(YearBucket_.year.equals(year)).build().findUnique();
    return bucket == null ? [] : bucket.months;
  }

  @override
  YearBucket? getYear(int year) {
    return _yearBox.query(YearBucket_.year.equals(year)).build().findUnique();
  }
}
