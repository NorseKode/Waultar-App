import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/startup.dart';
import 'package:waultar/configs/globals/category_enums.dart';

import '../test_helper.dart';

Future<void> main() async {
  late final IBucketsRepository _bucketsRepo;
  late final DateTime parsedAt;
  late final ProfileDocument testProfile;

  tearDownAll(() async {
    await TestHelper.tearDownServices();
  });

  setUpAll(() async {
    await TestHelper.runStartupScript();
    _bucketsRepo = locator.get<IBucketsRepository>(instanceName: 'bucketsRepo');
    parsedAt = DateTime.now();
    testProfile = TestHelper.seedForTimeBuckets();
    await _bucketsRepo.createBuckets(parsedAt, testProfile);
  });

  group('Creation of buckets from parsed datapoints', () {
    test(' - test buckets creation', () async {
      var yearBuckets = _bucketsRepo.getAllYears();
      expect(yearBuckets.length, 5);
      for (var year in yearBuckets) {
        expect(year.profile.target!.name, 'Test Profile Name');
      }

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
      var yearModels = _bucketsRepo.getAllYearModels(testProfile);
      expect(yearModels.length, 5);
      var year2022 = yearModels.last;
      expect(year2022.timeValue, 2022);
      expect(year2022.total, 3);
      expect(year2022.categoryCount.length, 1);
      expect(year2022.categoryCount.first.item1.categoryName, 'Posts');
      expect(year2022.categoryCount.first.item2, 3);
    });

    test(' - test bucket repo returning monthModels', () async {
      var yearModels = _bucketsRepo.getAllYearModels(testProfile);
      var year2022 = yearModels.last;
      var months = _bucketsRepo.getMonthModelsFromYear(year2022);
      expect(months.length, 2); // jan, mar, mar

      expect(months.first.total, 1);
      expect(months.first.timeValue, 1);
      expect(months.last.total, 2);
    });

    test(' - test bucket repo returning dayModels', () async {
      var yearModels = _bucketsRepo.getAllYearModels(testProfile);
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
      expect(fridayMarch.categoryCount.length, 1);
      expect(
          fridayMarch.categoryCount.first.item1.categoryName, 'Posts');

      var hour12_10 = _bucketsRepo.getHourModelsFromDay(fridayMarch);
      expect(hour12_10.length, 1);
      expect(hour12_10.first.timeValue, 12);
    });

    test(' - test bucket repo returning average computed for weekdays', () {
      var avgWeekDays = _bucketsRepo.getAverages(testProfile);
      expect(avgWeekDays.length, 7);
      var monday = avgWeekDays.first;
      expect(monday.weekDay, 1);
      expect(monday.profile.hasValue, true);
      expect(monday.profile.target!.name, 'Test Profile Name');
      var map = monday.averageCategoryMap;
      expect(map.length, 2);
    });

    test(' - updating sentiment in buckets via repo', () async {
      _bucketsRepo.updateForSentiments(testProfile);
      // let the islolates do their jobs before asserting
      await Future.delayed(const Duration(seconds: 3));
      var years = _bucketsRepo.getAllYears();

      var year2022 = years.first; // <== 2022 - three posts
      double totalScores = 0;
      int total = 0;
      for (var datapoint in year2022.dataPoints) {
        totalScores += datapoint.sentimentScore!;
        total++;
      }

      var postScore = year2022.categorySentimentAverage[CategoryEnum.posts]!;
      expect(postScore, totalScores/total);
    });
  });
}
