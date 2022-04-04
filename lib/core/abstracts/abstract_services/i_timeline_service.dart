import 'package:waultar/core/models/timeline/time_models.dart';
abstract class ITimelineService {
  /// returns all years in sorted order
  List<YearModel> getAllYears();
  List<MonthModel> getAllMonths();
  List<DayModel> getAllDays();
  List<DayModel> getDaysFrom(DateTime from);
  /// returns all months (max 12) from the given year in sorted order
  List<MonthModel> getMonthsFromYear(YearModel year);
  /// returns all days (max 31) from the given month in sorted order
  List<DayModel> getDaysFromMonth(MonthModel month);
  /// return all hours (max 24) from the given day in sorted order
  List<HourModel> getHoursFromDay(DayModel day);
}
