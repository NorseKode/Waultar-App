import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';

abstract class ISentimentService {
  double connotateText(String text);
  void connotateOwnTextsFromCategory(List<DataCategory> categories,
      Function(String message, bool isDone) callback);
  Future<void> connotateAllTextSeparateThreadFromDB();
  List<ProfileDocument> getAllProfiles();
}
