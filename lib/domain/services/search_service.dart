import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_search_service.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/startup.dart';

class SearchService extends ISearchService {
  final _dataRepo = locator.get<DataPointRepository>(instanceName: 'dataRepo');
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');

  @override
  List<UIModel> searchText(
      List<CategoryEnum> categories, List<int> profileIds, String search, int offset, int limit) {
    var ids = categories.map((e) => e.index).toList();
    profileIds.removeWhere((element) => element == 0);
    return _dataRepo.search(ids, profileIds, search, offset, limit);
  }

  @override
  List<ImageDocument> searchImages(List<int> profileIds, String search, int offset, int limit) {
    profileIds.removeWhere((element) => element == 0);
    return _mediaRepo.searchImagesPagination(search.trim().split(","), profileIds, offset, limit);
  }
}
