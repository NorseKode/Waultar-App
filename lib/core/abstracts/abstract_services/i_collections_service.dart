import 'package:waultar/core/inodes/tree_nodes.dart';

abstract class ICollectionsService {
  List<DataCategory> getAllCategories();
  List<DataPointName> getAllNamesFromCategory(DataCategory category);
  List<DataPoint> getAllDataPointsFromName(DataPointName name);
}