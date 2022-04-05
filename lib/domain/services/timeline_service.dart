import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_timeline_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/startup.dart';

class TimeLineService implements ITimelineService {
  final IBucketsRepository _bucketsRepo = locator.get<IBucketsRepository>(instanceName: 'bucketsRepo');
  final ProfileRepository _profileRepo = locator.get<ProfileRepository>(instanceName: 'profileRepo');
  TimeLineService();
  
  @override
  List<YearModel> getAllYears(ProfileDocument profile) {
    return _bucketsRepo.getAllYearModels(profile);
  }

  @override
  List<MonthModel> getAllMonths(ProfileDocument profile) {
    return _bucketsRepo.getAllMonthModels(profile);
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

  @override
  List<DayModel> getDaysFrom(DateTime from) {
    // call repo with from parameter
    // the to interval parameter should always be the same
    //  -> let's do 90 dayBuckets to start off with
    return _bucketsRepo.getDaysFrom(from);
  }

  @override
  List<ProfileDocument> getAllProfiles() {
    return _profileRepo.getAll();
  }


}
