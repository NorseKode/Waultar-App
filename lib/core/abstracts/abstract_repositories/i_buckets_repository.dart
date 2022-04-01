import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/timebuckets/day_bucket.dart';
import 'package:waultar/data/entities/timebuckets/month_bucket.dart';
import 'package:waultar/data/entities/timebuckets/year_bucket.dart';

abstract class IBucketsRepository {
  Future createBuckets(DateTime dataPointsCreatedAfter);
  List<YearBucket> getAllYears();
  YearBucket? getYear(int year);
  List<MonthBucket> getMonthsFromYearValue(int year);
  List<MonthBucket> getMonthsFromYearId(int yearId);
  List<DayBucket> getDaysFromMonth(MonthBucket month);
  List<DayBucket> getDaysFromMonthId(int monthId);
  List<DataPoint> getDataPointsFromDay(DayBucket day);
  List<YearModel> getAllYearModels();
  List<MonthModel> getAllMonthModels();
  List<DayModel> getAllDayModels();
  List<MonthModel> getMonthModelsFromYear(YearModel yearModel);
  List<DayModel> getDayModelsFromMonth(MonthModel monthModel);
  List<HourModel> getHourModelsFromDay(DayModel dayModel);
}