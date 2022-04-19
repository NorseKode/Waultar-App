import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';

abstract class ISentimentService {
  Map<int, int> get categoryCount;

  void calculateCategoryCount(List<int> categories);
  int getCategoryCount(int categoryId);
  double connotateText(String text);
  Future<void> connotateOwnTextsFromCategory(List<DataCategory> categories,
      Function(String message, bool isDone) callback, bool translate, {int threadCount = 1});
  Future<void> connotateAllTextSeparateThreadFromDB();
  List<ProfileDocument> getAllProfiles();
}
