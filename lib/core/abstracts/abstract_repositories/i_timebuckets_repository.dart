import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/timebuckets/buckets.dart';

abstract class ITimeBucketsRepository {
  List<YearModel> getAllYears();
  List<MonthModel> getAllMonthsFromYear(YearModel year);
  List<DayModel> getAllDaysFromMonth(MonthModel month);
  void save(int year, int month, int day, dynamic type);
}
