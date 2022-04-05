import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/timebuckets/day_bucket.dart';
import 'package:waultar/data/entities/timebuckets/month_bucket.dart';
import 'package:waultar/data/entities/timebuckets/weekday_average_bucket.dart';
import 'package:waultar/data/entities/timebuckets/year_bucket.dart';

abstract class IBucketsRepository {
  Future createBuckets(DateTime dataPointsCreatedAfter, ProfileDocument profile);
  List<YearBucket> getAllYears();
  YearBucket? getYear(int year);
  List<MonthBucket> getMonthsFromYearValue(int year);
  List<MonthBucket> getMonthsFromYearId(int yearId);
  List<DayBucket> getDaysFromMonth(MonthBucket month);
  List<DayBucket> getDaysFromMonthId(int monthId);
  List<DataPoint> getDataPointsFromDay(DayBucket day);
  List<YearModel> getAllYearModels(ProfileDocument profile);
  List<MonthModel> getAllMonthModels(ProfileDocument profile);
  List<DayModel> getDaysFrom(DateTime from);
  List<MonthModel> getMonthModelsFromYear(YearModel yearModel);
  List<DayModel> getDayModelsFromMonth(MonthModel monthModel);
  List<HourModel> getHourModelsFromDay(DayModel dayModel);
  List<DayBucket> getAllDayBuckets();
  List<MonthBucket> getAllMonthBuckets();
  List<YearBucket> getAllYearBuckets();
  List<WeekDayAverageComputed> getAverages(ProfileDocument profile);
}