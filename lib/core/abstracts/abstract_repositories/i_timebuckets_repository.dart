import 'package:waultar/core/models/timeline/time_models.dart';

abstract class ITimeBucketsRepository {
  List<YearModel> getAllYears();
  List<MonthModel> getAllMonthsFromYear(YearModel year);
  List<DayModel> getAllDaysFromMonth(MonthModel month);
  void save(int year, int month, int day, dynamic type);
}
