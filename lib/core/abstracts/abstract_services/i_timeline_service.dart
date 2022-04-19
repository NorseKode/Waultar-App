import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/domain/services/timeline_service.dart';

abstract class ITimelineService {
  void init();
  List<ProfileDocument> get allProfiles;
  ProfileDocument? get currentProfile;
  DateTimeIntervalType get currentXAxisInterval;
  List<UserAverageChartData> get averageCharData;
  List<UserSentimentChartData> get sentimentChartSeries;
  List<UserChartData> get chartData;
  List<ScatterSentimentDTO> get scatterChartPoints;
  DateTime get minimum;
  DateTime get maximum;
  // List<ScatterSentimentDTO> getScatterChartSeries();
  void updateMainChartSeries(num index);
  void updateProfile(ProfileDocument profile);
  void reset();
}
