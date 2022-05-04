import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/entities/media/image_document.dart';

abstract class ISearchService {
  List<UIModel> searchText(
      List<CategoryEnum> categories, List<int> profileIds, String search, int offset, int limit);
  List<ImageDocument> searchImages(List<int> profileIds, String search, int offset, int limit);
}
