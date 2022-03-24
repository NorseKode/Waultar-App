// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/timebuckets/buckets.dart';

import '../test_helper.dart';
import 'test_utils.dart';

void main() {

  late final ObjectBox _context;

  setUp(() async {
    await TestHelper.deleteTestDb();
    _context = await TestHelper.createTestDb();
  });

  tearDown(() async {
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
}