import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_dashboard_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/timebuckets/day_bucket.dart';
import 'package:waultar/data/entities/timebuckets/weekday_average_bucket.dart';
import 'package:waultar/data/entities/timebuckets/year_bucket.dart';
import 'package:waultar/data/repositories/buckets_repo.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_name_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/repositories/profile_repo.dart';

class DashboardService implements IDashboardService {
  final ProfileRepository _profileRepository;
  final DataCategoryRepository _categoryRepository;
  final DataPointNameRepository _dataPointNameRepository;
  final DataPointRepository _dataPointRepository;
  final BucketsRepository _bucketsRepository;

  DashboardService(
      this._bucketsRepository,
      this._profileRepository,
      this._categoryRepository,
      this._dataPointNameRepository,
      this._dataPointRepository);

  @override
  List<ProfileDocument> getAllProfiles() {
    return _profileRepository.getAll();
  }

  @override
  int getMostActiveYear() {
    var allYears = _bucketsRepository.getAllYears();
    if (allYears.isEmpty) return -1;
    YearBucket mostActive = allYears.first;
    for (var year in allYears) {
      if (year.total > mostActive.total) {
        mostActive = year;
      }
    }
    return mostActive.year;
  }

  @override
  List<Tuple2<String, double>> getActiveWeekday() {
    const namesMap = {
      -1: 'Unknown',
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };

    List<WeekDayAverageComputed> allWeekdays = [];
    for (var profile in getAllProfiles()) {
      allWeekdays.addAll(_bucketsRepository.getAverages(profile));
    }

    List<Tuple2<String, double>> weekdays = [];
    for (var day in allWeekdays) {
      double total = 0;
      day.averageCategoryMap.forEach((key, value) {
        total += value;
      });
      var presentIndex = weekdays
          .indexWhere((element) => element.item1 == namesMap[day.weekDay]!);

      if (presentIndex != -1) {
        weekdays[presentIndex] = Tuple2(
            weekdays[presentIndex].item1, weekdays[presentIndex].item2 + total);
      } else {
        weekdays.add(Tuple2(namesMap[day.weekDay]!, total));
      }
    }

    return weekdays;
  }

  @override
  List<Tuple2<String, int>> getSortedMessageCount(int? numberOfPeople) {
    return [];

    // List<DataCategory> allCategories = _categoryRepository.getAllCategories();
    // List<DataCategory> messageCategories = [];
    //

    // for (var category in allCategories) {
    //   if (category.category == CategoryEnum.messaging) {
    //     messageCategories.add(category);
    //   }
    // }

    // List<Tuple2<String, int>> allThreads = [];
    // for (var category in messageCategories) {
    //   for (var dataname in category.dataPointNames) {
    //     print(dataname.dataPoints.first.asMap);
    //     allThreads.add(Tuple2(dataname.name, 1));
    //   }
    // }

    // allThreads.sort((a, b) => b.item2.compareTo(a.item2));
    // if (numberOfPeople != null) {
    //   return allThreads.getRange(0, numberOfPeople).toList();
    // }
    // return allThreads;
  }
}
