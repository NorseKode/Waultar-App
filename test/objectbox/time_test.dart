// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/inodes/buckets_repo.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/timebuckets/buckets.dart';

import '../test_helper.dart';

void main() async {
  late final ObjectBox _context;
  late final IBucketsRepository _bucketsRepo;

  setUpAll(() async {
    await TestHelper.deleteTestDb();
    _context = await TestHelper.createTestDb();
    _bucketsRepo = BucketsRepository(_context);
  });

  tearDownAll(() async {
    _context.store.close();
    await Timer(const Duration(seconds: 2), () {});
    await TestHelper.deleteTestDb();
  });

  group('Creation of buckets from parsed datapoints', () {

    test(' - test setup', () {
      var now = DateTime.now();

      TestHelper.seedForTimeBuckets(_context);
      var dataBox = _context.store.box<DataPoint>();

      var dataCount = dataBox.count();
      expect(dataCount, 10);

      var greaterThenParsedTime = dataBox
          .query(
              DataPoint_.dbCreatedAt.greaterThan(now.microsecondsSinceEpoch))
          .build()
          .count();
      expect(greaterThenParsedTime, 10);

      var later = DateTime.now();
      var greaterThenLaterTime = dataBox
          .query(
              DataPoint_.dbCreatedAt.greaterThan(later.microsecondsSinceEpoch))
          .build().count();
      expect(greaterThenLaterTime, 0);
    });

    test(' - test buckets creation', () async {
      var parsedAt = DateTime.now();
      TestHelper.seedForTimeBuckets(_context);
      await _bucketsRepo.createBuckets(parsedAt);

      var yearBuckets = _bucketsRepo.getAllYears();
      expect(yearBuckets.length, 5);

      var year2022 = _bucketsRepo.getYear(2022)!;
      expect(year2022.months.length, 2);

      var year2022Months = _bucketsRepo.getMonthsFromYearValue(2022);
      expect(year2022Months.length, 2);
      expect(year2022Months.first.month, 3);

      var days = _bucketsRepo.getDaysFromMonth(year2022Months.first);
      expect(days.length, 2);

      var datapoints = _bucketsRepo.getDataPointsFromDay(days.first);
      expect(datapoints.length, 1);
      expect(days.first.dataPoints.first.id, datapoints.first.id);
    });

    test(' - test year buckets count', () async {
      var count = _bucketsRepo.getAllYears().length;
      expect(count, 0);
    });

    test(' - test bucket mapping from db property to Map<int, int>', () async {
      var yearBucket = YearBucket(year: 2023);
      yearBucket.categoryMap.addAll({1:30});
      var _yearBox = _context.store.box<YearBucket>();
      int createdId = _yearBox.put(yearBucket);
      var created = _yearBox.get(createdId)!;

      var map = created.categoryMap;
      expect(map.length, 1);
      expect(map.keys.first, 1);
    });

    test(' - test bucket repo returning yearModels', () async {
      var parsedAt = DateTime.now();
      TestHelper.seedForTimeBuckets(_context);
      await _bucketsRepo.createBuckets(parsedAt);
      var yearModels = _bucketsRepo.getAllYearModels();
      expect(yearModels.length, 5);
    });


  });
}
