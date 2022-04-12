import 'package:tuple/tuple.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';

abstract class IDashboardService {
  List<ProfileDocument> getAllProfiles();
  List<Tuple2<String, int>> getSortedMessageCount(int? numberOfPeople);
}
