import 'dart:convert';
import 'package:objectbox/objectbox.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/core/helpers/json_helper.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/timebuckets/month_bucket.dart';

@Entity()
class YearBucket {
  int id;

  @Unique()
  int year;

  @Property(type: PropertyType.dateNano)
  DateTime dateTime;

  int total;

  late Map<CategoryEnum, double> categorySentimentAverage;

  late Map<int, int> categoryMap;
  late Map<int, int> profileMap;

  final months = ToMany<MonthBucket>();
  final dataPoints = ToMany<DataPoint>();
  final profile = ToOne<ProfileDocument>();

  YearBucket({
    this.id = 0,
    this.total = 0,
    required this.year,
    required this.dateTime,
  }) {
    categoryMap = {};
    profileMap = {};
    categorySentimentAverage = {};
  }

  int get dbDateTime => dateTime.microsecondsSinceEpoch;
  set dbDateTime(int value) {
    dateTime = DateTime.fromMicrosecondsSinceEpoch(value, isUtc: false);
  }

  String get dbCategorySentimentAverage => jsonEncode(categorySentimentAverage
      .map((key, value) => MapEntry('${key.index}', value)));
  set dbCategorySentimentAverage(String json) {
    categorySentimentAverage = Map.from(jsonDecode(json).map((key, value) =>
        MapEntry(CategoryEnum.values[int.parse(key)], value as double)));
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
      profileMap.addAll({serviceId: 1});
      return 1;
    });
    total = total + 1;
  }

  Future updateSentiment() async {
    var stream = Stream.fromIterable(
        dataPoints.where((datapoint) => datapoint.sentimentScore != null));

    Map<CategoryEnum, Tuple2<int, double>> _tempSentimentMap = {};

    await for (final datapoint in stream) {
      var catEnum = datapoint.category.target!.category;

      _tempSentimentMap.update(catEnum, (value) {
        var updated = value
            .withItem1(value.item1 + 1)
            .withItem2(value.item2 + datapoint.sentimentScore!);
        return updated;
      }, ifAbsent: () {
        return Tuple2(1, datapoint.sentimentScore!);
      });
    }

    for (var entry in _tempSentimentMap.entries) {
      categorySentimentAverage
          .addAll({entry.key: entry.value.item2 / entry.value.item1});
    }

    _tempSentimentMap.clear();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'total': total,
      'categoryMap': JsonHelper.convertIntIntMap(categoryMap),
      'profileMap': JsonHelper.convertIntIntMap(profileMap),
      'months': JsonHelper.convertToManyToJson(months),
      'dbDateTime': dbDateTime,
      'dbCategoryMap': dbCategoryMap,
      'dbServiceMap': dbServiceMap,
    };
  }
}
