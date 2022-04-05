import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';

abstract class ISentimentService {
  double connotateText(String text);
  int connotateOwnTextsFromCategory(List<DataCategory> categories);
  Future<void> connotateAllTextSeparateThreadFromDB();
  List<ProfileDocument> getAllProfiles();
}
