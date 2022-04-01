import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/configs/globals/search_categories_enum.dart';
import 'package:waultar/core/abstracts/abstract_services/i_text_search_service.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/startup.dart';

class TextSearchService extends ITextSearchService {
  final _dataRepo = locator.get<DataPointRepository>(instanceName: 'dataRepo');

  @override
  List<UIModel> search(List<CategoryEnum> categories, String search, int offset, int limit) {
    var ids = categories.map((e) => e.index).toList();
    return _dataRepo.search(ids, search, offset, limit);
  }

}
