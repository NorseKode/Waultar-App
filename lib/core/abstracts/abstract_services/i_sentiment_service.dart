import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';

abstract class ISentimentService {
  double connotateText(String text);
  int connotateTextsFromCategory(List<DataCategory> categories);
  Future<void> connotateAllTextSeparateThreadFromDB();
  List<ProfileDocument> getAllProfiles();
}
