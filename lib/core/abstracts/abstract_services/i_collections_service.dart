import 'package:waultar/core/inodes/inode.dart';

abstract class ICollectionsService {
  List<DataCategory> getAllCategories();
  List<DataPointName> getAllNamesFromCategory(DataCategory category);
  List<DataPoint> getAllDataPointsFromName(DataPointName name);
}