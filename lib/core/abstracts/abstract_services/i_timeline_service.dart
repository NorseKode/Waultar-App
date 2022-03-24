import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/core/models/ui_model.dart';

abstract class ITimelineService {
  List<YearModel> getAllYears();
  List<MonthModel> getMonthsFromYear(YearModel year);
  List<DayModel> getDaysFromMonth(MonthModel month);
  List<UIModel> getUIModelsFromDay(DayModel day);
  List<DataPoint> getDataPointsFromDay(DayModel day);
}
