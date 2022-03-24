// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/core/inodes/buckets_repo.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/timebuckets/buckets.dart';

import '../test_helper.dart';
import 'test_utils.dart';

void main() {
  late final ObjectBox _context;
  late final IBucketsRepository _bucketsRepo;

  setUpAll(() async {
    await TestHelper.deleteTestDb();
    _context = await TestHelper.createTestDb();
    _bucketsRepo = BucketsRepository(_context);
  });

  tearDownAll(() async {
    _context.store.close();
    await TestHelper.deleteTestDb();
  });

  test('test input and output timestamp persist', () async {
    var box = _context.store.box<DateTimeTest>();
    var newTimestamp = DateTimeTest();
    newTimestamp.color = ColorEnum.black;
    print('created -> ${newTimestamp.timestamp.toString()}');

    var createdId = box.put(newTimestamp);
    var updatedTimestamp = box.get(createdId);
    print('updated -> ${updatedTimestamp!.timestamp.toString()}');
    print('created -> ${newTimestamp.color.toString()}');
    updatedTimestamp.color = ColorEnum.white;
    box.put(updatedTimestamp);
    var updatedColor = box.get(createdId)!;
    var stringTimes = <String>[];

    for (var i = 0; i < 10; i++) {
      stringTimes.add(DateTime.now().microsecondsSinceEpoch.toString());
    }

    updatedColor.timestamps = stringTimes;
    print(updatedColor.timestamps.toString());

    await Future.delayed(const Duration(seconds: 2));
    box.putQueued(updatedColor);
    _context.store.awaitAsyncSubmitted();

    var updatedbytevector = box.get(updatedColor.id)!;
    print(updatedbytevector.timestamps.toString());
    print(updatedbytevector.timestamp.toString());
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
    });

    test(' - test year buckets count', () {
      var count = _bucketsRepo.getAllYears().length;
      expect(count, 0);
    });

    test(' - test bucket mapping from db property to Map<int, int>', () {
      var yearBucket = YearBucket(year: 2022);
      yearBucket.categoryMap.addAll({1:30});
      var _yearBox = _context.store.box<YearBucket>();
      int createdId = _yearBox.put(yearBucket);
      var created = _yearBox.get(createdId)!;

      var map = created.categoryMap;
      expect(map.length, 1);
      expect(map.keys.first, 1);

    });

    test(' - test day bucket count', () {
    });

    test(' - test buckets creation throws', () {
    });

  });
}
