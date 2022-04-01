import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/models/ui_model.dart';

abstract class ITextSearchService {
  List<UIModel> search(List<CategoryEnum> categories, String search, int offset, int limit);
}
