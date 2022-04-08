import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/timebuckets/weekday_average_bucket.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/startup.dart';

class TimeLineService implements ITimelineService {
  TimeLineService() {
    _mainChartSeries = [];
    _averageChartSeries = [];
    _sentimentChartSeries = [];
    _profiles = [];
    _currentTimeIntervalForChart = DateTimeIntervalType.auto;
  }

  @override
  void init() {
    _profiles = _profileRepo.getAll();
    if (_profiles.isNotEmpty) {
      _currentProfile = _profiles.first;
      _currentTimeSeries = _bucketsRepo.getAllYearModels(_currentProfile!);
      _currentTimeIntervalForChart = DateTimeIntervalType.years;
      _setChartSeries();
      _setAverageChartSeries();
    }
  }

  final IBucketsRepository _bucketsRepo =
      locator.get<IBucketsRepository>(instanceName: 'bucketsRepo');
  final ProfileRepository _profileRepo =
      locator.get<ProfileRepository>(instanceName: 'profileRepo');

  late List<TimeModel> _currentTimeSeries;
  late ProfileDocument? _currentProfile;
  late List<ProfileDocument> _profiles;
  late DateTimeIntervalType _currentTimeIntervalForChart;

  late List<TimelineCategoryChartObject> _mainChartSeries;
  late List<AverageChartObject> _averageChartSeries;
  late List<SentimentChartObject> _sentimentChartSeries;
  late TimelineProfileChartObject _profileTotalChartSeries;

  @override
  List<ProfileDocument> get allProfiles => _profiles;

  @override
  List<AverageChartObject> get averageWeekDayChartSeries => _averageChartSeries;

  @override
  ProfileDocument? get currentProfile => _currentProfile;

  @override
  DateTimeIntervalType get currentXAxisInterval => _currentTimeIntervalForChart;

  @override
  List<TimelineCategoryChartObject> get mainChartCategorySeries =>
      _mainChartSeries;

  @override
  TimelineProfileChartObject get mainChartProfileTotalSeries =>
      _profileTotalChartSeries;

  @override
  List<SentimentChartObject> get sentimentChartSeries => _sentimentChartSeries;

  @override
  DateTime get minimum => _currentTimeSeries.first.dateTime;
  @override
  DateTime get maximum => _currentTimeSeries.last.dateTime;

  @override
  void updateMainChartSeries(num index) {
    var model = _currentTimeSeries[index.round()];
    if (model.runtimeType != HourModel) {
      _currentTimeSeries = _getInnerValues(model);
      _setChartSeries();
      _setCurrentXIntervalEnum();
    }
  }

  @override
  void updateProfile(ProfileDocument profile) {
    if (profile.id != _currentProfile!.id) {
      _currentProfile = profile;
      _setChartSeries();
      _setAverageChartSeries();
      _setCurrentXIntervalEnum();
    }
  }

  @override
  void reset() {
    _currentTimeSeries = _bucketsRepo.getAllYearModels(_currentProfile!);
    _setChartSeries();
    _setCurrentXIntervalEnum();
  }

  void _setAverageChartSeries() {
    var averageDocuments = _bucketsRepo.getAverages(_currentProfile!);
    var updatedAverageList = <AverageChartObject>[];

    for (var catEnum in CategoryEnum.values) {
      updatedAverageList.add(AverageChartObject(category: catEnum));
    }

    for (var document in averageDocuments) {
      for (var item in updatedAverageList) {
        var exists = document.averageCategoryMap.entries.any(
          (element) => element.key.index == item.category.index,
        );
        if (exists) {
          var entry = document.averageCategoryMap.entries.singleWhere(
            (element) => element.key.index == item.category.index,
          );
          item.chartDataPoints.add(
            WeekDayWithAverage(
              average: entry.value,
              weekDay: document.weekDay.weekDayName,
            ),
          );
        } else {
          item.chartDataPoints.add(
            WeekDayWithAverage(
              average: 0.0,
              weekDay: document.weekDay.weekDayName,
            ),
          );
        }
      }
    }

    updatedAverageList.removeWhere(
      (element) {
        var accumulated = element.chartDataPoints.fold<double>(
          0.0,
          (previousValue, element) => previousValue + element.average,
        );
        return accumulated == 0.0;
      },
    );

    _averageChartSeries = updatedAverageList;
  }

  void _setChartSeries() {
    var updatedMainList = <TimelineCategoryChartObject>[];
    var updatedSentimentList = <SentimentChartObject>[];
    var updatedProfileChartObject = TimelineProfileChartObject(
      profile: _currentProfile!,
    );

    for (var catEnum in CategoryEnum.values) {
      updatedMainList.add(TimelineCategoryChartObject(category: catEnum));
      updatedSentimentList.add(SentimentChartObject(category: catEnum));
    }

    for (var timeModel in _currentTimeSeries) {
      updatedProfileChartObject.chartDataPoints.add(TimeUnitWithTotal(
        timeValue: timeModel.dateTime,
        total: timeModel.total,
      ));

      for (var item in updatedMainList) {
        if (timeModel.categoryCount.any(
            (element) => element.item1.index == item.category.index)) {
          var tuple = timeModel.categoryCount.singleWhere(
              (element) => element.item1.index == item.category.index);
          item.chartDataPoints.add(
            TimeUnitWithTotal(
              timeValue: timeModel.dateTime,
              total: tuple.item2,
            ),
          );
        } else {
          item.chartDataPoints.add(
            TimeUnitWithTotal(
              timeValue: timeModel.dateTime,
              total: 0,
            ),
          );
        }
      }

      for (var item in updatedSentimentList) {
        if (timeModel.sentimentScores
            .any((element) => element.item1.index == item.category.index)) {
          var tuple = timeModel.sentimentScores.singleWhere(
              (element) => element.item1.index == item.category.index);
          item.chartDataPoints.add(
            SentimentWithAverage(
              timeValue: timeModel.dateTime,
              score: tuple.item2,
            ),
          );
        } else {
          item.chartDataPoints.add(
            SentimentWithAverage(
              timeValue: timeModel.dateTime,
              score: 0.0,
            ),
          );
        }
      }
    }

    updatedMainList.removeWhere(
      (element) {
        var accumulated = element.chartDataPoints.fold<int>(
            0, (previousValue, element) => previousValue + element.total);
        return accumulated == 0;
      },
    );

    updatedSentimentList.removeWhere(
      (element) {
        var accumulated = element.chartDataPoints.fold<double>(
            0.0, (previousValue, element) => previousValue + element.score);
        return accumulated == 0.0;
      },
    );

    _mainChartSeries = updatedMainList;
    _sentimentChartSeries = updatedSentimentList;
    _profileTotalChartSeries = updatedProfileChartObject;
  }

  void _setCurrentXIntervalEnum() {
    var currentFirst = _currentTimeSeries.first;
    switch (currentFirst.runtimeType) {
      case YearModel:
        _currentTimeIntervalForChart = DateTimeIntervalType.years;
        break;
      case MonthModel:
        _currentTimeIntervalForChart = DateTimeIntervalType.months;
        break;
      case DayModel:
        _currentTimeIntervalForChart = DateTimeIntervalType.days;
        break;
      case HourModel:
        _currentTimeIntervalForChart = DateTimeIntervalType.hours;
        break;
      default:
        _currentTimeIntervalForChart = DateTimeIntervalType.auto;
    }
  }

  List<TimeModel> _getInnerValues(TimeModel timeModel) {
    switch (timeModel.runtimeType) {
      case YearModel:
        return _bucketsRepo.getMonthModelsFromYear(timeModel as YearModel);
      case MonthModel:
        return _bucketsRepo.getDayModelsFromMonth(timeModel as MonthModel);
      case DayModel:
        return _bucketsRepo.getHourModelsFromDay(timeModel as DayModel);
      default:
        return [];
    }
  }

  List<MonthModel> getAllMonths(ProfileDocument profile) {
    return _bucketsRepo.getAllMonthModels(profile);
  }

  List<DayModel> getDaysFromMonth(MonthModel month) {
    return _bucketsRepo.getDayModelsFromMonth(month);
  }

  List<MonthModel> getMonthsFromYear(YearModel year) {
    return _bucketsRepo.getMonthModelsFromYear(year);
  }

  List<HourModel> getHoursFromDay(DayModel day) {
    return _bucketsRepo.getHourModelsFromDay(day);
  }

  List<DayModel> getDaysFrom(DateTime from) {
    // call repo with from parameter
    // the to interval parameter should always be the same
    //  -> let's do 90 dayBuckets to start off with
    return _bucketsRepo.getDaysFrom(from);
  }

  List<ProfileDocument> getAllProfiles() {
    return _profileRepo.getAll();
  }

  List<WeekDayAverageComputed> getAverages(ProfileDocument profile) {
    return _bucketsRepo.getAverages(profile);
  }

  List<YearModel> getAllYears(ProfileDocument profile) {
    return _bucketsRepo.getAllYearModels(profile);
  }
}

class TimelineCategoryChartObject {
  CategoryEnum category;
  late List<TimeUnitWithTotal> chartDataPoints;
  TimelineCategoryChartObject({required this.category}) {
    chartDataPoints = [];
  }
}

class TimelineProfileChartObject {
  ProfileDocument profile;
  late List<TimeUnitWithTotal> chartDataPoints;
  TimelineProfileChartObject({required this.profile}) {
    chartDataPoints = [];
  }
}

class TimeUnitWithTotal {
  DateTime timeValue;
  int total;
  TimeUnitWithTotal({
    required this.timeValue,
    required this.total,
  });

  @override
  String toString() {
    return 'timeValue -> ${timeValue.toString()} total -> $total';
  }
}

class AverageChartObject {
  CategoryEnum category;
  late List<WeekDayWithAverage> chartDataPoints;
  AverageChartObject({required this.category}) {
    chartDataPoints = [];
  }
}

class WeekDayWithAverage {
  String weekDay;
  double average;
  WeekDayWithAverage({
    required this.average,
    required this.weekDay,
  });
}

extension WeekDayHelper on int {
  static const namesMap = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };

  String get weekDayName => namesMap[this] ?? 'Unkown';
}

class SentimentChartObject {
  CategoryEnum category;
  late List<SentimentWithAverage> chartDataPoints;
  SentimentChartObject({
    required this.category,
  }) {
    chartDataPoints = [];
  }
}

class SentimentWithAverage {
  DateTime timeValue;
  double score;
  SentimentWithAverage({
    required this.timeValue,
    required this.score,
  });
}
