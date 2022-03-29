import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';

abstract class ICollectionsService {
  List<DataCategory> getAllCategories();
  List<DataPointName> getAllNamesFromCategory(DataCategory category);
  List<DataPoint> getAllDataPointsFromName(DataPointName name);
}