import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/core/models/ui_model.dart';

abstract class ITimeBucketsRepository {
  List<YearModel> getAllYears();
  List<MonthModel> getAllMonthsFromYear(YearModel year);
  List<DayModel> getAllDaysFromMonth(MonthModel month);
  List<DataPoint> getAllDataPointsFromDay(DayModel day);
  List<UIModel> getAllUIModelsFromDay(DayModel day);
  void generateBuckets();
}
