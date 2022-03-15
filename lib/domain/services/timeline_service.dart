import 'package:waultar/core/abstracts/abstract_repositories/i_timebuckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/core/models/timeline/time_models.dart';

class TimeLineService implements ITimelineService {
  final ITimeBucketsRepository _timeRepo;
  TimeLineService(this._timeRepo);
  @override
  List<YearModel> getAllYears() {
    return _timeRepo.getAllYears();
  }

  @override
  List<DayModel> getDaysFromMonth(MonthModel month) {
    return _timeRepo.getAllDaysFromMonth(month);
  }

  @override
  List<UIModel> getModelsFromDay(DayModel day) {
    throw UnimplementedError();
  }

  @override
  List<MonthModel> getMonthsFromYear(YearModel year) {
    return _timeRepo.getAllMonthsFromYear(year);
  }
}
