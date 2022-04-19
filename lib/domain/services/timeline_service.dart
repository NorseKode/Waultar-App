import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/timebuckets/weekday_average_bucket.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/startup.dart';

class TimeLineService implements ITimelineService {
  TimeLineService() {
    _profiles = [];
    _currentTimeSeries = [];
    _chartData = [];
    _averageChartData = [];
    _sentimentChartSeries = [];
    _scatterChartPoints = [];
    _currentIndex = [];

    _currentTimeIntervalForChart = DateTimeIntervalType.auto;
    _allProfilesRepresenter = ProfileDocument(name: 'All');
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
      _setAverageChartSeries();
      _setIndexTimeSeries();
      _setScatterChartSeries();
    }
  }

  final IBucketsRepository _bucketsRepo = locator.get<IBucketsRepository>(
    instanceName: 'bucketsRepo',
  );
  final ProfileRepository _profileRepo = locator.get<ProfileRepository>(
    instanceName: 'profileRepo',
  );
  final DataPointRepository _dataRepo = locator.get<DataPointRepository>(
    instanceName: 'dataRepo',
  );

  late DateTimeIntervalType _currentTimeIntervalForChart;
  late Duration _edgeDuration;
  ProfileDocument? _currentProfile;
  late ProfileDocument _allProfilesRepresenter;
  late List<ProfileDocument> _profiles;

  late List<TimeModel> _currentTimeSeries;
  late List<DateTime> _currentIndex;
  late List<UserChartData> _chartData;
  late List<UserAverageChartData> _averageChartData;
  late List<UserSentimentChartData> _sentimentChartSeries;
  late List<ScatterSentimentDTO> _scatterChartPoints;

  @override
  List<UserChartData> get chartData => _chartData;

  @override
  List<UserAverageChartData> get averageCharData => _averageChartData;

  @override
  List<ScatterSentimentDTO> get scatterChartPoints => _scatterChartPoints;

  @override
  List<ProfileDocument> get allProfiles => _profiles;

  @override
  ProfileDocument? get currentProfile => _currentProfile;

  @override
  DateTimeIntervalType get currentXAxisInterval => _currentTimeIntervalForChart;

  @override
  List<UserSentimentChartData> get sentimentChartSeries =>
      _sentimentChartSeries;

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
      _setCurrentXIntervalEnum();
    }
  }

  @override
  void updateProfile(ProfileDocument profile) {
    if (profile.id != _currentProfile!.id) {
      _currentProfile = profile;
      reset();
      _setAverageChartSeries();
      _setScatterChartSeries();
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
    _setCurrentXIntervalEnum();
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
    _averageChartData.clear();
    List<ProfileDocument> profiles = _currentProfile!.id == 0
        ? _profiles.where((element) => element.id != 0).toList()
        : [_currentProfile!];
    for (var profile in profiles) {
      var averageUserChart = UserAverageChartData(
        profileId: profile.id,
        userName: profile.name,
        serviceName: profile.service.target!.serviceName,
      );
      var documents = _bucketsRepo.getAverages(profile);
      for (var document in documents) {
        averageUserChart.averageSeries
            .add(WeekDayAverageChartPoint.fromComputedDocument(document));
      }
      _averageChartData.add(averageUserChart);
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
        userChart.sentimentSeries
            .add(SentimentChartPoint.fromTimeModel(timeModel));
      }
      userChartSeries.add(userChart);
    }
    _chartData = userChartSeries;
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

  void _setScatterChartSeries() {
    if (_currentProfile!.id == 0) {
      var actualProfiles = _profiles.where((element) => element.id != 0).toList();
      _scatterChartPoints = _dataRepo.getDataPointsWithSentiment(actualProfiles);
    } else {
      _scatterChartPoints = _dataRepo.getDataPointsWithSentiment([_currentProfile!]);
    }
  }
}

class UserChartData {
  late int profileId;
  late String userName;
  late String serviceName;
  late List<CategoryChartData> categorySeries;
  late List<SentimentChartPoint> sentimentSeries;
  UserChartData({
    required this.profileId,
    required this.userName,
    required this.serviceName,
  }) {
    categorySeries = [];
    sentimentSeries = [];
  }
}

class UserSentimentChartData {
  late int profileId;
  late String userName;
  late String serviceName;
  late List<SentimentChartPoint> averageSeries;
  UserSentimentChartData({
    required this.profileId,
    required this.userName,
    required this.serviceName,
  }) : averageSeries = [];
}

class SentimentChartPoint {
  late DateTime xValue;
  late List<Tuple2<CategoryEnum, double>> yValues;
  SentimentChartPoint({
    required this.xValue,
  }) : yValues = [];

  SentimentChartPoint.fromTimeModel(TimeModel model) {
    xValue = model.dateTime;
    yValues = List.generate(CategoryEnum.values.length, (index) {
      var category = CategoryEnum.values[index];
      var yValue = model.sentimentScores
          .firstWhere((element) => element.item1.index == index,
              orElse: () => Tuple2(category, -1.0))
          .item2;
      return Tuple2(category, yValue);
    });
  }
}

class UserAverageChartData {
  late int profileId;
  late String userName;
  late String serviceName;
  late List<WeekDayAverageChartPoint> averageSeries;
  UserAverageChartData({
    required this.profileId,
    required this.userName,
    required this.serviceName,
  }) : averageSeries = [];
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

class WeekDayAverageChartPoint {
  late String xValue; // <== weekday
  late List<Tuple2<CategoryEnum, double>> yValues;
  WeekDayAverageChartPoint({
    required this.xValue,
  }) {
    yValues = [];
  }

  WeekDayAverageChartPoint.fromComputedDocument(
      WeekDayAverageComputed document) {
    xValue = document.weekDay.weekDayName;
    yValues = List.generate(CategoryEnum.values.length, (index) {
      var category = CategoryEnum.values[index];
      var yValue = document.averageCategoryMap.entries.firstWhere(
          (element) => element.key.index == index,
          orElse: () => MapEntry(category, 0.0));
      return Tuple2(category, yValue.value);
    });
  }
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
