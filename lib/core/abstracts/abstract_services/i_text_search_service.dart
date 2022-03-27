import 'package:waultar/configs/globals/search_categories_enum.dart';
import 'package:waultar/core/models/ui_model.dart';

abstract class ITextSearchService {
  List<UIModel> search(Map<SearchCategories, bool> inputCategories, String search, int limit, int offset);
  List<UIModel> searchAll(String search, int offset, int limit);
}
