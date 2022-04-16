import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tuple/tuple.dart';
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
    _allProfilesRepresenter = ProfileDocument(name: 'All');
    _currentIndex = [];
    _chartData = [];
    _edgeDuration = const Duration(days: 365);
  }

  @override
  void init() {
    _profiles = _profileRepo.getAll();
    if (_profiles.isNotEmpty) {
      _currentProfile = _profiles.first;
      _profiles.add(_allProfilesRepresenter);
      _currentTimeSeries = _bucketsRepo.getAllYearModels(_currentProfile!);
      _currentTimeIntervalForChart = DateTimeIntervalType.years;
      _setUserChartDataSeries();
      _setChartSeries();
      _setAverageChartSeries();
      _setIndexTimeSeries();
    }
  }

  final IBucketsRepository _bucketsRepo =
      locator.get<IBucketsRepository>(instanceName: 'bucketsRepo');
  final ProfileRepository _profileRepo =
      locator.get<ProfileRepository>(instanceName: 'profileRepo');

  late List<TimeModel> _currentTimeSeries;
  late DateTimeIntervalType _currentTimeIntervalForChart;

  late List<TimelineCategoryChartObject> _mainChartSeries;
  late List<AverageChartObject> _averageChartSeries;
  late List<SentimentChartObject> _sentimentChartSeries;
  late TimelineProfileChartObject _profileTotalChartSeries;
  late ProfileDocument _allProfilesRepresenter;

  late ProfileDocument? _currentProfile;
  late List<ProfileDocument> _profiles;
  late List<UserChartData> _chartData;
  late List<DateTime> _currentIndex;
  late Duration _edgeDuration;

  @override
  List<UserChartData> get chartData => _chartData;

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

  void _setEdgeLabelDuration() {
    switch (_currentTimeIntervalForChart) {
      case DateTimeIntervalType.years:
        _edgeDuration = const Duration(days: 365);
        break;
      case DateTimeIntervalType.months:
        _edgeDuration = const Duration(days: 31);
        break;
      case DateTimeIntervalType.days:
        _edgeDuration = const Duration(days: 1);
        break;
      case DateTimeIntervalType.hours:
        _edgeDuration = const Duration(hours: 4);
        break;
      default:
        print(_currentTimeIntervalForChart.name);
        break;
    }
  }

  @override
  DateTime get minimum {
    _setEdgeLabelDuration();
    return _currentIndex.first.add(-_edgeDuration);
  }

  @override
  DateTime get maximum {
    _setEdgeLabelDuration();
    return _currentIndex.last.add(_edgeDuration);
  }

  @override
  void updateMainChartSeries(num index) {
    int selectedTimeValue = 0;
    var selectedTime = DateTime.fromMillisecondsSinceEpoch(index as int);
    if (_currentTimeIntervalForChart == DateTimeIntervalType.years) {
      selectedTimeValue = selectedTime.year;
    }
    if (_currentTimeIntervalForChart == DateTimeIntervalType.months) {
      selectedTimeValue = selectedTime.month;
    }
    if (_currentTimeIntervalForChart == DateTimeIntervalType.days) {
      selectedTimeValue = selectedTime.day;
    }
    
    // var selectedTime = _currentIndex[index.round()];
    if (_currentTimeIntervalForChart != DateTimeIntervalType.hours) {
      var timeModelsToRetrieveFrom = _currentTimeSeries
          .where((element) => element.timeValue == selectedTimeValue)
          .toList();
      var updatedList = <TimeModel>[];
      for (var item in timeModelsToRetrieveFrom) {
        updatedList.addAll(_getInnerValues(item));
      }
      _currentTimeSeries = updatedList;
      _setUserChartDataSeries();
      _setIndexTimeSeries();
      _setChartSeries();
      _setCurrentXIntervalEnum();
    }
  }

  @override
  void updateProfile(ProfileDocument profile) {
    if (profile.id != _currentProfile!.id) {
      _currentProfile = profile;
      reset();
      _setAverageChartSeries();
    }
  }

  @override
  void reset() {
    if (_currentProfile == null) return;
    if (_currentProfile!.id != 0) {
      _currentTimeSeries = _bucketsRepo.getAllYearModels(_currentProfile!);
    } else {
      _currentTimeSeries.clear();
      var actualProfiles = _profiles.where((element) => element.id != 0);
      for (var profile in actualProfiles) {
        _currentTimeSeries.addAll(_bucketsRepo.getAllYearModels(profile));
      }
    }
    _setUserChartDataSeries();
    _setIndexTimeSeries();
    _setChartSeries();
    _setCurrentXIntervalEnum();
    print(_chartData.length);
  }

  void _setIndexTimeSeries() {
    _currentIndex.clear();
    Set<DateTime> xAxisSet = {};
    for (var timeModel in _currentTimeSeries) {
      xAxisSet.add(timeModel.dateTime);
    }
    _currentIndex = xAxisSet.toList();
    _currentIndex.sort((a, b) => a.compareTo(b));
  }

  void _setAverageChartSeries() {
    var averageDocuments = <WeekDayAverageComputed>[];
    if (_currentProfile!.id != 0) {
      _bucketsRepo.getAverages(_currentProfile!);
    } else {
      var actualProfiles = _profiles.where((element) => element.id != 0);
      for (var profile in actualProfiles) {
        averageDocuments.addAll(_bucketsRepo.getAverages(profile));
      }
    }

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
        if (timeModel.categoryCount
            .any((element) => element.item1.index == item.category.index)) {
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
    //  -> from + 90 days
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

  void _setUserChartDataSeries() {
    List<UserChartData> userChartSeries = [];
    List<ProfileDocument> profiles = _currentProfile!.id == 0
        ? _profiles.where((element) => element.id != 0).toList()
        : [_currentProfile!];
    for (var profile in profiles) {
      var userChart = UserChartData(
        profileId: profile.id,
        userName: profile.name,
        serviceName: profile.service.target!.serviceName,
      );
      var timeModels = _currentTimeSeries
          .where((element) => element.profile.id == profile.id)
          .toList();
      timeModels.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      for (var timeModel in timeModels) {
        userChart.categorySeries
            .add(CategoryChartData.fromTimeModel(timeModel));
      }
      // userChart.categorySeries.sort((a, b) => a.xValue.compareTo(b.xValue));
      userChartSeries.add(userChart);
    }

    _chartData = userChartSeries;
  }
}

class UserChartData {
  late int profileId;
  late String userName;
  late String serviceName;
  late List<CategoryChartData> categorySeries;
  UserChartData({
    required this.profileId,
    required this.userName,
    required this.serviceName,
  }) {
    categorySeries = [];
  }
}

class CategoryChartData {
  late DateTime xValue;
  late int total;
  late List<Tuple2<CategoryEnum, int>> yValues;
  CategoryChartData({
    required this.xValue,
    required this.total,
  }) : yValues = [];

  CategoryChartData.fromTimeModel(TimeModel model) {
    xValue = model.dateTime;
    total = model.total;
    yValues = List.generate(CategoryEnum.values.length, (index) {
      var category = CategoryEnum.values[index];
      var yValue = model.categoryCount
          .firstWhere((element) => element.item1.index == index,
              orElse: () => Tuple2(category, 0))
          .item2;
      return Tuple2(category, yValue);
    });
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
