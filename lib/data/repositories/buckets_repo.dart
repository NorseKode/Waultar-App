// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/timebuckets/day_bucket.dart';
import 'package:waultar/data/entities/timebuckets/hour_bucket.dart';
import 'package:waultar/data/entities/timebuckets/month_bucket.dart';
import 'package:waultar/data/entities/timebuckets/year_bucket.dart';

class BucketsRepository extends IBucketsRepository {
  final ObjectBox _context;
  late final Box<YearBucket> _yearBox;
  late final Box<MonthBucket> _monthBox;
  late final Box<DayBucket> _dayBox;
  late final Box<DataCategory> _categoryBox;
  late final Box<ProfileDocument> _profileBox;

  BucketsRepository(this._context) {
    _yearBox = _context.store.box<YearBucket>();
    _monthBox = _context.store.box<MonthBucket>();
    _dayBox = _context.store.box<DayBucket>();
    _categoryBox = _context.store.box<DataCategory>();
    _profileBox = _context.store.box<ProfileDocument>();
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

  @override
  List<DataPoint> getDataPointsFromDay(DayBucket day) {
    var dayBucket = _dayBox.get(day.id);
    return dayBucket == null ? [] : dayBucket.dataPoints;
  }

  @override
  List<YearModel> getAllYearModels() {
    var listToReturn = <YearModel>[];
    _context.store.runInTransaction(TxMode.read, () {
      var years = _yearBox.getAll();
      for (var year in years) {
        var categoryTuples = <Tuple2<DataCategory, int>>[];
        var profileTuples = <Tuple2<ProfileDocument, int>>[];
        var categoryMap = year.categoryMap;
        var profileMap = year.profileMap;

        for (var entry in categoryMap.entries) {
          DataCategory category = _getCategory(entry.key);
          categoryTuples.add(Tuple2(category, entry.value));
        }
        for (var entry in profileMap.entries) {
          ProfileDocument profile = _getProfile(entry.key);
          profileTuples.add(Tuple2(profile, entry.value));
        }

        var model = YearModel(
          id: year.id,
          year: year.year,
          total: year.total,
          dateTime: year.dateTime,
          categoryCount: categoryTuples,
          profileCount: profileTuples,
        );

        listToReturn.add(model);
      }
    });
    listToReturn.sort((a, b) => a.timeValue.compareTo(b.timeValue));
    return listToReturn;
  }

  @override
  List<MonthModel> getAllMonthModels() {
    var listToReturn = <MonthModel>[];
    _context.store.runInTransaction(TxMode.read, () {
      var months = _monthBox.getAll();
      for (var month in months) {
        var categoryTuples = <Tuple2<DataCategory, int>>[];
        var profileTuples = <Tuple2<ProfileDocument, int>>[];
        var categoryMap = month.categoryMap;
        var profileMap = month.profileMap;

        for (var entry in categoryMap.entries) {
          DataCategory category = _getCategory(entry.key);
          categoryTuples.add(Tuple2(category, entry.value));
        }
        for (var entry in profileMap.entries) {
          ProfileDocument profile = _getProfile(entry.key);
          profileTuples.add(Tuple2(profile, entry.value));
        }

        var model = MonthModel(
          id: month.id,
          month: month.month,
          total: month.total,
          dateTime: month.dateTime,
          categoryCount: categoryTuples,
          profileCount: profileTuples,
        );

        listToReturn.add(model);
      }
    });
    listToReturn.sort((a, b) => a.timeValue.compareTo(b.timeValue));
    return listToReturn;
  }

  @override
  List<DayModel> getAllDayModels() {
    var listToReturn = <DayModel>[];
    _context.store.runInTransaction(TxMode.read, () {
      var days = _dayBox.getAll();
      for (var day in days) {
        var categoryTuples = <Tuple2<DataCategory, int>>[];
        var profileTuples = <Tuple2<ProfileDocument, int>>[];
        var categoryMap = day.categoryMap;
        var profileMap = day.profileMap;

        for (var entry in categoryMap.entries) {
          DataCategory category = _getCategory(entry.key);
          categoryTuples.add(Tuple2(category, entry.value));
        }
        for (var entry in profileMap.entries) {
          ProfileDocument profile = _getProfile(entry.key);
          profileTuples.add(Tuple2(profile, entry.value));
        }

        var model = DayModel(
          id: day.id,
          day: day.day,
          total: day.total,
          dateTime: day.dateTime,
          categoryCount: categoryTuples,
          profileCount: profileTuples,
          dataPoints: day.dataPoints.map((d) => d.getUIDTO).toList(),
        );

        listToReturn.add(model);
      }
    });
    listToReturn.sort((a, b) => a.timeValue.compareTo(b.timeValue));
    return listToReturn;
  }

  @override
  List<DayModel> getDayModelsFromMonth(MonthModel monthModel) {
    var listToReturn = <DayModel>[];
    _context.store.runInTransaction(TxMode.read, () {
      var monthBucket = _monthBox.get(monthModel.id);
      if (monthBucket == null) return [];

      var days = monthBucket.days.toList();
      for (var day in days) {
        var categoryTuples = <Tuple2<DataCategory, int>>[];
        var profileTuples = <Tuple2<ProfileDocument, int>>[];
        var categoryMap = day.categoryMap;
        var profileMap = day.profileMap;

        for (var entry in categoryMap.entries) {
          DataCategory category = _getCategory(entry.key);
          categoryTuples.add(Tuple2(category, entry.value));
        }
        for (var entry in profileMap.entries) {
          ProfileDocument profile = _getProfile(entry.key);
          profileTuples.add(Tuple2(profile, entry.value));
        }

        var model = DayModel(
          id: day.id,
          day: day.day,
          total: day.total,
          dateTime: day.dateTime,
          categoryCount: categoryTuples,
          profileCount: profileTuples,
          dataPoints: day.dataPoints.map((d) => d.getUIDTO).toList(),
        );
        listToReturn.add(model);
      }
    });

    listToReturn.sort((a, b) => a.timeValue.compareTo(b.timeValue));
    return listToReturn;
  }

  @override
  List<HourModel> getHourModelsFromDay(DayModel dayModel) {
    var listToReturn = <HourModel>[];
    _context.store.runInTransaction(TxMode.read, () {
      var dayBucket = _dayBox.get(dayModel.id);
      if (dayBucket == null) return [];

      var hours = dayBucket.hours.toList();
      for (var hour in hours) {
        var categoryTuples = <Tuple2<DataCategory, int>>[];
        var profileTuples = <Tuple2<ProfileDocument, int>>[];
        var categoryMap = hour.categoryMap;
        var profileMap = hour.profileMap;

        for (var entry in categoryMap.entries) {
          DataCategory category = _getCategory(entry.key);
          categoryTuples.add(Tuple2(category, entry.value));
        }
        for (var entry in profileMap.entries) {
          ProfileDocument profile = _getProfile(entry.key);
          profileTuples.add(Tuple2(profile, entry.value));
        }

        var model = HourModel(
          id: hour.id,
          hour: hour.hour,
          total: hour.total,
          dateTime: hour.dateTime,
          categoryCount: categoryTuples,
          profileCount: profileTuples,
          dataPoints: hour.dataPoints.map((d) => d.getUIDTO).toList(),
        );
        listToReturn.add(model);
      }
    });

    listToReturn.sort((a, b) => a.timeValue.compareTo(b.timeValue));
    return listToReturn;
  }

  @override
  List<MonthModel> getMonthModelsFromYear(YearModel yearModel) {
    var listToReturn = <MonthModel>[];
    _context.store.runInTransaction(TxMode.read, () {
      var yearBucket = _yearBox.get(yearModel.id);
      if (yearBucket == null) return [];

      var months = yearBucket.months.toList();
      for (var month in months) {
        var categoryTuples = <Tuple2<DataCategory, int>>[];
        var profileTuples = <Tuple2<ProfileDocument, int>>[];
        var categoryMap = month.categoryMap;
        var profileMap = month.profileMap;

        for (var entry in categoryMap.entries) {
          DataCategory category = _getCategory(entry.key);
          categoryTuples.add(Tuple2(category, entry.value));
        }
        for (var entry in profileMap.entries) {
          ProfileDocument service = _getProfile(entry.key);
          profileTuples.add(Tuple2(service, entry.value));
        }

        var model = MonthModel(
          id: month.id,
          month: month.month,
          total: month.total,
          dateTime: month.dateTime,
          categoryCount: categoryTuples,
          profileCount: profileTuples,
        );
        listToReturn.add(model);
      }
    });

    listToReturn.sort((a, b) => a.timeValue.compareTo(b.timeValue));
    return listToReturn;
  }

  @override
  Future createBuckets(DateTime dataPointsCreatedAfter) async {
    var createdSince = dataPointsCreatedAfter.microsecondsSinceEpoch;

    var years = _yearBox.getAll();

    // streams all datapoints that have been created after createdSince
    var toBeProcessedQuery = _context.store
        .box<DataPoint>()
        .query(DataPoint_.dbCreatedAt.greaterThan(createdSince))
        .build();

    var toBeProcessed = toBeProcessedQuery.stream();
    // process each datapoint from the stream
    await for (final dataPoint in toBeProcessed.distinct()) {
      var timestamps = _scrapeUniqueTimestamps(dataPoint);

      if (timestamps.isNotEmpty) {
        int categoryId = dataPoint.category.targetId;
        int profileId = dataPoint.profile.targetId;

        for (var timestamp in timestamps) {
          var dissected = _dissectDateTime(timestamp);

          // the values lie in the tuple
          int year = dissected.item1;
          int month = dissected.item2;
          int day = dissected.item3;
          int hour = dissected.item4;

          bool yearExists = years.any((element) => element.year == year);
          if (yearExists) {
            var yearBucket =
                years.singleWhere((element) => element.year == year);
            yearBucket.updateCounts(categoryId, profileId);

            bool monthExists =
                yearBucket.months.any((element) => element.month == month);

            if (monthExists) {
              var monthBucket = yearBucket.months
                  .singleWhere((element) => element.month == month);
              monthBucket.updateCounts(categoryId, profileId);

              bool dayExists =
                  monthBucket.days.any((element) => element.day == day);
              if (dayExists) {
                var dayBucket = monthBucket.days
                    .singleWhere((element) => element.day == day);
                dayBucket.updateCounts(categoryId, profileId);
                dayBucket.dataPoints.add(dataPoint);

                bool hourExists =
                    dayBucket.hours.any((element) => element.hour == hour);
                if (hourExists) {
                  var hourBucket = dayBucket.hours
                      .singleWhere((element) => element.hour == hour);
                  hourBucket.updateCounts(categoryId, profileId);
                  hourBucket.dataPoints.add(dataPoint);
                } else {
                  var hourBucket = HourBucket(
                    hour: hour,
                    total: 1,
                    dateTime: DateTime(year, month, day, hour),
                  );
                  hourBucket.categoryMap = {categoryId: 1};
                  hourBucket.profileMap = {profileId: 1};
                  hourBucket.dataPoints.add(dataPoint);

                  dayBucket.hours.add(hourBucket);
                }
              } else {
                var dayBucket = DayBucket(
                  day: day,
                  total: 1,
                  dateTime: DateTime(year, month, day),
                );
                dayBucket.categoryMap = {categoryId: 1};
                dayBucket.profileMap = {profileId: 1};
                dayBucket.dataPoints.add(dataPoint);

                var hourBucket = HourBucket(
                  hour: hour,
                  total: 1,
                  dateTime: DateTime(year, month, day, hour),
                );
                hourBucket.categoryMap = {categoryId: 1};
                hourBucket.profileMap = {profileId: 1};
                hourBucket.dataPoints.add(dataPoint);

                // create the relation in bottom-up order
                dayBucket.hours.add(hourBucket);
                monthBucket.days.add(dayBucket);
              }
            } else {
              var monthBucket = MonthBucket(
                month: month,
                total: 1,
                dateTime: DateTime(year, month),
              );
              monthBucket.categoryMap = {categoryId: 1};
              monthBucket.profileMap = {profileId: 1};

              var dayBucket = DayBucket(
                day: day,
                total: 1,
                dateTime: DateTime(year, month, day),
              );
              dayBucket.categoryMap = {categoryId: 1};
              dayBucket.profileMap = {profileId: 1};
              dayBucket.dataPoints.add(dataPoint);

              var hourBucket = HourBucket(
                hour: hour,
                total: 1,
                dateTime: DateTime(year, month, day, hour),
              );
              hourBucket.categoryMap = {categoryId: 1};
              hourBucket.profileMap = {profileId: 1};
              hourBucket.dataPoints.add(dataPoint);

              // create the relation in bottom-up order
              dayBucket.hours.add(hourBucket);
              monthBucket.days.add(dayBucket);
              yearBucket.months.add(monthBucket);
            }
          } else {
            // if the year is not present we have to create a new bucket for each time entity
            // this also includes a new map for each bucket, as these are initiated to = {};
            var yearBucket = YearBucket(
              year: year,
              total: 1,
              dateTime: DateTime(year),
            );
            yearBucket.categoryMap = {categoryId: 1};
            yearBucket.profileMap = {profileId: 1};

            var monthBucket = MonthBucket(
              month: month,
              total: 1,
              dateTime: DateTime(year, month),
            );
            monthBucket.categoryMap = {categoryId: 1};
            monthBucket.profileMap = {profileId: 1};

            var dayBucket = DayBucket(
              day: day,
              total: 1,
              dateTime: DateTime(year, month, day, hour),
            );
            dayBucket.categoryMap = {categoryId: 1};
            dayBucket.profileMap = {profileId: 1};
            dayBucket.dataPoints.add(dataPoint);

            var hourBucket = HourBucket(
              hour: hour,
              total: 1,
              dateTime: DateTime(year, month, day, hour),
            );
            hourBucket.categoryMap = {categoryId: 1};
            hourBucket.profileMap = {profileId: 1};
            hourBucket.dataPoints.add(dataPoint);

            // create the relation in bottom-up order
            dayBucket.hours.add(hourBucket);
            monthBucket.days.add(dayBucket);
            yearBucket.months.add(monthBucket);
            years.add(yearBucket);
          }
        }
      }
    }

    // when the stream has processed each element we update all the buckets via the root bucket in a single transaction
    toBeProcessedQuery.close();
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
      if (data is int) {
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

    return null;
  }

  Tuple4<int, int, int, int> _dissectDateTime(DateTime timestamp) {
    int year = timestamp.year;
    int month = timestamp.month;
    int day = timestamp.day;
    int hour = timestamp.hour;
    return Tuple4(year, month, day, hour);
  }

  DataCategory _getCategory(int id) {
    var category = _categoryBox.get(id);
    if (category == null) {
      return _categoryBox
          .query(DataCategory_.dbCategory.equals(CategoryEnum.unknown.index))
          .build()
          .findUnique()!;
    } else {
      return category;
    }
  }

  ProfileDocument _getProfile(int id) => _profileBox.get(id)!;
}
