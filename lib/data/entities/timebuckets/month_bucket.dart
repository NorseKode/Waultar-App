import 'dart:convert';
import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/timebuckets/day_bucket.dart';
import 'package:waultar/data/entities/timebuckets/year_bucket.dart';

@Entity()
class MonthBucket {
  int id;
  int month;
  int total;

  late Map<int, int> categoryMap;
  late Map<int, int> profileMap;

  final year = ToOne<YearBucket>();
  final days = ToMany<DayBucket>();

  MonthBucket({
    this.id = 0,
    this.total = 0,
    required this.month,
  }) {
    categoryMap = {};
    profileMap = {};
  }

  String get dbCategoryMap =>
      jsonEncode(categoryMap.map((key, value) => MapEntry('$key', value)));
  String get dbServiceMap =>
      jsonEncode(profileMap.map((key, value) => MapEntry('$key', value)));
  set dbCategoryMap(String json) {
    categoryMap = Map.from(jsonDecode(json)
        .map((key, value) => MapEntry(int.parse(key), value as int)));
  }

  set dbServiceMap(String json) {
    profileMap = Map.from(jsonDecode(json)
        .map((key, value) => MapEntry(int.parse(key), value as int)));
  }

  void updateCounts(int categoryId, int serviceId) {
    categoryMap.update(categoryId, (value) => value + 1, ifAbsent: () {
      categoryMap.addAll({categoryId: 1});
      return 1;
    });
    profileMap.update(serviceId, (value) => value + 1, ifAbsent: () {
      profileMap.addAll({serviceId:1});
      return 1;
    });
    total = total + 1;
  }
  
}