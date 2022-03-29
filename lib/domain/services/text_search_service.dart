import 'package:waultar/configs/globals/search_categories_enum.dart';
import 'package:waultar/core/abstracts/abstract_services/i_text_search_service.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/startup.dart';

class TextSearchService extends ITextSearchService {
  final _dataRepo = locator.get<DataPointRepository>(instanceName: 'dataRepo');

  @override
  List<UIModel> search(Map<SearchCategories, bool> inputCategories, String search, int limit, int offset) {
    var returnList = <UIModel>[];

    // inputCategories.forEach((key, value) {
    //   if (key == SearchCategories.post && value) {
    //     returnList.addAll(_postRepo.search(search, offset, limit - 10));
    //   }
    //   if (key == SearchCategories.media && value) {
    //     returnList.addAll(_imageRepo.search(search, offset, limit - 10));
    //   }
    //   if(key == SearchCategories.comment && value) {
    //     returnList.addAll(_commentRepo.search(search, offset, limit - 10));
    //   }
    // });

    return returnList;
  }

  @override
  List<UIModel> searchAll(String search, int offset, int limit) {
    return _dataRepo.search(search, offset, limit);
  }
}
