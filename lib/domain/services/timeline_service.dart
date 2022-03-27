import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/inodes/buckets_repo.dart';
import 'package:waultar/core/models/timeline/time_models.dart';

class TimeLineService implements ITimelineService {
  final IBucketsRepository _bucketsRepo;
  TimeLineService(this._bucketsRepo);
  
  @override
  List<YearModel> getAllYears() {
    return _bucketsRepo.getAllYearModels();
  }

  @override
  List<DayModel> getDaysFromMonth(MonthModel month) {
    return _bucketsRepo.getDayModelsFromMonth(month);
  }

  @override
  List<MonthModel> getMonthsFromYear(YearModel year) {
    return _bucketsRepo.getMonthModelsFromYear(year);
  }

  @override
  List<HourModel> getHoursFromDay(DayModel day) {
    return _bucketsRepo.getHourModelsFromDay(day);
  }

}
