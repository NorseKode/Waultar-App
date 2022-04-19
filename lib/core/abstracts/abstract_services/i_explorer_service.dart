import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';

abstract class IExplorerService {
  List<ProfileDocument> getAllProfiles();
  List<DataCategory> getAllCategories(int profileID);
  List<DataPointName> getAllDatanames(int categoryID);
  List<DataPoint> getAllDataPoints(int datapointnameID);
}
