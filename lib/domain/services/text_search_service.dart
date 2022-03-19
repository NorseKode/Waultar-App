import 'package:waultar/configs/globals/search_categories_enum.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_comment_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_image_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_text_search_service.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/startup.dart';

class TextSearchService extends ITextSearchService {
  final _postRepo = locator.get<IPostRepository>(instanceName: 'postRepo');
  final _imageRepo = locator.get<IImageRepository>(instanceName: 'imageRepo');
  final _commentRepo = locator.get<ICommentRepository>(instanceName: 'commentRepo');
  final _dataRepo = locator.get<DataPointRepository>(instanceName: 'dataRepo');

  @override
  List<UIModel> search(Map<SearchCategories, bool> inputCategories, String search, int limit, int offset) {
    var returnList = <UIModel>[];

    inputCategories.forEach((key, value) {
      if (key == SearchCategories.post && value) {
        returnList.addAll(_postRepo.search(search, offset, limit - 10));
      }
      if (key == SearchCategories.media && value) {
        returnList.addAll(_imageRepo.search(search, offset, limit - 10));
      }
      if(key == SearchCategories.comment && value) {
        returnList.addAll(_commentRepo.search(search, offset, limit - 10));
      }
    });

    return returnList;
  }

  List<UIModel> searchAll(String search, int offset, int limit) {
    var returnList = <UIModel>[];


    return returnList;
  }
}
