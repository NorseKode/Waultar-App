import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/timebuckets/weekday_average_bucket.dart';
abstract class ITimelineService {
  /// returns all years in sorted order
  List<YearModel> getAllYears(ProfileDocument profile);
  List<MonthModel> getAllMonths(ProfileDocument profile);
  List<DayModel> getDaysFrom(DateTime from);
  List<TimeModel> getInnerValues(TimeModel timeModel);
  List<WeekDayAverageComputed> getAverages(ProfileDocument profile);
  /// returns all months (max 12) from the given year in sorted order
  List<MonthModel> getMonthsFromYear(YearModel year);
  /// returns all days (max 31) from the given month in sorted order
  List<DayModel> getDaysFromMonth(MonthModel month);
  /// return all hours (max 24) from the given day in sorted order
  List<HourModel> getHoursFromDay(DayModel day);
  List<ProfileDocument> getAllProfiles();
}
