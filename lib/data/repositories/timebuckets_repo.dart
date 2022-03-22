// import 'dart:convert';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:objectbox/objectbox.dart';
// import 'package:tuple/tuple.dart';
// import 'package:waultar/core/abstracts/abstract_repositories/i_timebuckets_repository.dart';
// import 'package:waultar/core/models/timeline/time_models.dart';
// import 'package:waultar/data/configs/objectbox.dart';
// import 'package:waultar/data/configs/objectbox.g.dart';
// import 'package:waultar/data/entities/content/event_objectbox.dart';
// import 'package:waultar/data/entities/content/group_objectbox.dart';
// import 'package:waultar/data/entities/content/post_objectbox.dart';
// import 'package:waultar/data/entities/timebuckets/buckets.dart';
// import 'package:waultar/data/repositories/model_builders/i_model_director.dart';

// import 'objectbox_builders/i_objectbox_director.dart';

// class TimeBucketsRepository implements ITimeBucketsRepository {
//   late final ObjectBox _context;
//   late final Box<YearBucket> _yearBox;
//   late final Box<MonthBucket> _monthBox;
//   late final Box<DayBucket> _dayBox;

//   TimeBucketsRepository(this._context) {
//     _yearBox = _context.store.box<YearBucket>();
//     _monthBox = _context.store.box<MonthBucket>();
//     _dayBox = _context.store.box<DayBucket>();
//   }

//   @override
//   void save(int year, int month, int day, dynamic type) {
//     String stringType = _getCategory(type);

//     var yearEntity =
//         _yearBox.query(YearBucket_.year.equals(year)).build().findUnique();

//     if (yearEntity == null) {
//       var map = {stringType: 1};
//       String encoded = jsonEncode(map);
//       yearEntity = YearBucket(year: year, stringMap: encoded);
//     }

//     var yearMap = jsonDecode(yearEntity.stringMap) as Map<String, dynamic>;
//     yearMap.update(stringType, (dynamic value) => value == null ? 1 : ++value,
//         ifAbsent: () => yearMap.addAll({stringType: 1}));
//     yearEntity.stringMap = jsonEncode(yearMap);

//     yearEntity.total += 1;

//     var monthEntity = yearEntity.months.toList().singleWhere(
//         (element) => element.month == month,
//         orElse: () =>
//             MonthBucket(month: month, stringMap: jsonEncode({stringType: 0})));

//     var map = jsonDecode(monthEntity.stringMap) as Map<String, dynamic>;
//     map.update(stringType, (dynamic value) => value == null ? 1 : ++value,
//         ifAbsent: () => map.addAll({stringType: 1}));
//     monthEntity.stringMap = jsonEncode(map);

//     monthEntity.total += 1;

//     var dayEntity = monthEntity.days.toList().singleWhere(
//         (element) => element.day == day,
//         orElse: () =>
//             DayBucket(day: day, stringMap: jsonEncode({stringType: 0})));

//     var dayMap = jsonDecode(dayEntity.stringMap) as Map<String, dynamic>;
//     dayMap.update(stringType, (dynamic value) => value == null ? 1 : ++value,
//         ifAbsent: () => dayMap.addAll({stringType: 1}));
//     dayEntity.stringMap = jsonEncode(dayMap);

//     dayEntity.total += 1;

//     switch (type.runtimeType) {
//       case PostObjectBox:
//         dayEntity.posts.add(type);
//         break;
//       case GroupObjectBox:
//         dayEntity.groups.add(type);
//         break;
//       case EventObjectBox:
//         dayEntity.events.add(type);
//         break;
//     }
//     monthEntity.days.add(dayEntity);
//     int createdId = _monthBox.put(monthEntity);
//     var updatedMonth = _monthBox.get(createdId)!;
//     yearEntity.months.add(updatedMonth);
//     _yearBox.put(yearEntity);
//   }

//   String _getCategory(dynamic type) {
//     switch (type.runtimeType) {
//       case PostObjectBox:
//         return "Posts";
//       case GroupObjectBox:
//         return "Groups";
//       case EventObjectBox:
//         return "Events";
//       default:
//         return "";
//     }
//   }

//   @override
//   List<DayModel> getAllDaysFromMonth(MonthModel month) {
//     var monthEntity = _monthBox.get(month.id)!;
//     var days = monthEntity.days;
//     days.sort((a, b) => a.day.compareTo(b.day));
//     var returnList = <DayModel>[];
//     for (var day in days.toList()) {
//       int id = day.id;
//       int dayValue = day.day;
//       int total = day.total;

//       var entries = <Tuple3<int, String, Color>>[];
//       var map = jsonDecode(day.stringMap) as Map<String, dynamic>;
//       for (var entry in map.entries) {
//         Color color = Colors.deepOrange;
//         if (entry.key == "Posts") color = Colors.deepPurple;
//         if (entry.key == "Groups") color = Colors.greenAccent;
//         entries.add(Tuple3(entry.value, entry.key, color));
//       }
//       returnList.add(DayModel(id, dayValue, total, entries));
//     }
//     return returnList;
//   }

//   @override
//   List<MonthModel> getAllMonthsFromYear(YearModel year) {
//     var yearEntity = _yearBox.get(year.id)!;
//     var months = yearEntity.months;
//     months.sort((a, b) => a.month.compareTo(b.month));
//     var returnList = <MonthModel>[];
//     for (var month in months) {
//       int id = month.id;
//       int monthValue = month.month;
//       int total = month.total;

//       var entries = <Tuple3<int, String, Color>>[];
//       var map = jsonDecode(month.stringMap) as Map<String, dynamic>;
//       for (var entry in map.entries) {
//         Color color = Colors.deepOrange;
//         if (entry.key == "Posts") color = Colors.deepPurple;
//         if (entry.key == "Groups") color = Colors.greenAccent;
//         entries.add(Tuple3(entry.value, entry.key, color));
//       }
//       returnList.add(MonthModel(id, monthValue, total, entries));
//     }
//     return returnList;
//   }

//   @override
//   List<YearModel> getAllYears() {
//     var query = _yearBox.query();
//     query.order(YearBucket_.year);
//     var years = query.build().find();
//     var returnList = <YearModel>[];
//     for (var year in years) {
//       int id = year.id;
//       int yearValue = year.year;
//       int total = year.total;

//       var entries = <Tuple3<int, String, Color>>[];
//       var map = jsonDecode(year.stringMap) as Map<String, dynamic>;
//       for (var entry in map.entries) {
//         Color color = Colors.deepOrange;
//         if (entry.key == "Posts") color = Colors.deepPurple;
//         if (entry.key == "Groups") color = Colors.greenAccent;
//         entries.add(Tuple3(entry.value, entry.key, color));
//       }
//       returnList.add(YearModel(id, yearValue, total, entries));
//     }

//     return returnList;
//   }
// }
