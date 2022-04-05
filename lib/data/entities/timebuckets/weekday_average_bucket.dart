import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';

@Entity()
class WeekDayAverageComputed {
  int id;

  // monday, tuesday etc..
  // there will only be one bucket per weekday per profile
  // [1..7]
  int weekDay;

  // this should be stored in db
  late Map<CategoryEnum, double> averageCategoryMap;

  final profile = ToOne<ProfileDocument>();

  // this is used only when building the object
  @Transient()
  late Map<CategoryEnum, Tuple2<List<DateTime>, int>> _tempMap;

  WeekDayAverageComputed({
    this.id = 0,
    required this.weekDay,
  }) {
    averageCategoryMap = {};
    _tempMap = {};
  }

  String get dbAverageCategoryMap =>
      jsonEncode(averageCategoryMap.map((key, value) => MapEntry('$key', value)));

  set dbAverageCategoryMap(String json) {
    averageCategoryMap =
        Map.from(jsonDecode(json).map((key, value) => MapEntry(key, value as double)));
  }

  void updateTemp(DataPoint datapoint, DateTime day) {
    var categoryEnum = datapoint.category.target!.category;
      _tempMap.update(categoryEnum, (value) {
        var tuple = value;
        if (tuple.item1.contains(day)) {
          var updated = tuple.withItem2(tuple.item2 + 1);
          return updated;
        } else {
          tuple.item1.add(day);
          var updated = tuple.withItem2(tuple.item2 + 1);
          return updated;
        }
      }, ifAbsent: () {
        return Tuple2([day], 1);
      });
  }

  void calculateAverages() {
    for (var entry in _tempMap.entries) {
      var category = entry.key;
      double average = entry.value.item2 / entry.value.item1.length;
      averageCategoryMap.addAll({category:average});
    }
  }
}
