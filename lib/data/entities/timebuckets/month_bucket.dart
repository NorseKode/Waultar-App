import 'dart:convert';
import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/helpers/json_helper.dart';
import 'package:waultar/data/entities/timebuckets/day_bucket.dart';
import 'package:waultar/data/entities/timebuckets/year_bucket.dart';

@Entity()
class MonthBucket {
  int id;
  int month;

  @Property(type: PropertyType.dateNano)
  DateTime dateTime;
  int total;

  late Map<int, int> categoryMap;
  late Map<int, int> profileMap;

  final year = ToOne<YearBucket>();
  final days = ToMany<DayBucket>();

  MonthBucket({
    this.id = 0,
    this.total = 0,
    required this.month,
    required this.dateTime,
  }) {
    categoryMap = {};
    profileMap = {};
  }

  int get dbDateTime => dateTime.microsecondsSinceEpoch;
  set dbDateTime(int value) {
    dateTime = DateTime.fromMicrosecondsSinceEpoch(value, isUtc: false);
  }

  String get dbCategoryMap => jsonEncode(categoryMap.map((key, value) => MapEntry('$key', value)));
  String get dbServiceMap => jsonEncode(profileMap.map((key, value) => MapEntry('$key', value)));
  set dbCategoryMap(String json) {
    categoryMap =
        Map.from(jsonDecode(json).map((key, value) => MapEntry(int.parse(key), value as int)));
  }

  set dbServiceMap(String json) {
    profileMap =
        Map.from(jsonDecode(json).map((key, value) => MapEntry(int.parse(key), value as int)));
  }

  void updateCounts(int categoryId, int serviceId) {
    categoryMap.update(categoryId, (value) => value + 1, ifAbsent: () {
      categoryMap.addAll({categoryId: 1});
      return 1;
    });
    profileMap.update(serviceId, (value) => value + 1, ifAbsent: () {
      profileMap.addAll({serviceId: 1});
      return 1;
    });
    total = total + 1;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'month': month,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'total': total,
      'categoryMap': JsonHelper.convertIntIntMap(categoryMap),
      'profileMap': JsonHelper.convertIntIntMap(profileMap),
      'year': year.targetId,
      'days': JsonHelper.convertToManyToJson(days),
      'dbDateTime': dbDateTime,
      'dbCategoryMap': dbCategoryMap,
      'dbServiceMap': dbServiceMap,
    };
  }
}
