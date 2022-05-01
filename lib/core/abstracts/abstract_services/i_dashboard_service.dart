import 'package:tuple/tuple.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';

abstract class IDashboardService {
  List<ProfileDocument> getAllProfiles();
  int getMostActiveYear();
  List<Tuple2<String, double>> getActiveWeekday();
  List<Tuple2<String, int>> getSortedMessageCount(int? numberOfPeople);
}
