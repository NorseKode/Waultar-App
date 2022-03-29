import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/startup.dart';
import 'package:waultar/configs/globals/category_enums.dart';


import '../test_helper.dart';

Future<void> main() async {
  late final IBucketsRepository _bucketsRepo;
  late final DateTime parsedAt;

  tearDownAll(() async {
    await TestHelper.tearDownServices();
  });
  
  setUpAll(() async {
    await TestHelper.runStartupScript();
    _bucketsRepo = locator.get<IBucketsRepository>(instanceName: 'bucketsRepo');
    parsedAt = DateTime.now();
    TestHelper.seedForTimeBuckets();
    await _bucketsRepo.createBuckets(parsedAt);
  });


  group('Creation of buckets from parsed datapoints', () {

    test(' - test buckets creation', () async {

      var yearBuckets = _bucketsRepo.getAllYears();
      expect(yearBuckets.length, 5);

      var year2022 = _bucketsRepo.getYear(2022)!;
      expect(year2022.months.length, 2);
      expect(year2022.total, 3);

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
      expect(count, 5);
    });

    test(' - test bucket repo returning yearModels', () async {
      var yearModels = _bucketsRepo.getAllYearModels();
      expect(yearModels.length, 5);
      var year2022 = yearModels.last;
      expect(year2022.timeValue, 2022);
      expect(year2022.total, 3);
      expect(year2022.categoryCount.length, 1);
      expect(year2022.categoryCount.first.item1.category.name, 'Posts');
      expect(year2022.categoryCount.first.item2, 3);
      expect(year2022.profileCount.length, 1);
    });

    test(' - test bucket repo returning monthModels', () async {
      var yearModels = _bucketsRepo.getAllYearModels();
      var year2022 = yearModels.last;
      var months = _bucketsRepo.getMonthModelsFromYear(year2022);
      expect(months.length, 2); // jan, mar, mar

      expect(months.first.total, 1);
      expect(months.first.profileCount.length, 1);
      expect(months.first.timeValue, 1);
      expect(months.last.total, 2);
    });

    test(' - test bucket repo returning dayModels', () async {
      var yearModels = _bucketsRepo.getAllYearModels();
      var year2022 = yearModels.last;
      var months = _bucketsRepo.getMonthModelsFromYear(year2022);

      expect(months.length, 2); // mar, mar, jan
      var march = months.last;

      var days = _bucketsRepo.getDayModelsFromMonth(march);
      expect(days.length, 2);
      expect(days.first.total, 1);
      expect(days.first.timeValue, 18);
      expect(days.last.timeValue, 20);

      var fridayMarch = days.first;
      expect(fridayMarch.dataPoints.length, 1);
      expect(fridayMarch.dataPoints.first.getAssociatedColor(), Colors.amber);
      expect(fridayMarch.profileCount.length, 1);
      expect(fridayMarch.categoryCount.length, 1);
      expect(fridayMarch.categoryCount.first.item1.category.name, 'Posts');

      var hour12_10 = _bucketsRepo.getHourModelsFromDay(fridayMarch);
      expect(hour12_10.length, 1);
      expect(hour12_10.first.timeValue, 12);
    });
  });
}
