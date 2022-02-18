import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/repositories/post_repo.dart';
import 'package:waultar/startup.dart';

abstract class ParserServiceBase {
  // gets called by the uploader --> returns the paths
  // parse said files --> the two parsers
  // save parsed objects --> repositories
  //
  // on error throw exception
  void parseAll(List<String> paths, ServiceModel service);
}

class ParserService extends ParserServiceBase {
  final IPostRepository _postRepo = locator.get<IPostRepository>(instanceName: 'postRepo');

  @override
  parseAll(List<String> paths, ServiceModel service) async* {
    // TODO: implement parseAll
    switch (service.name) {
      case "Facebook":
        await for (final entity in FacebookParser().parseListOfPaths(paths)) {
          _todoName(entity);
        }
        break;

      case "Instagram":
        InstagramParser().parseListOfPaths(paths);
        break;
      default:
    }
  }

  _todoName(dynamic model) {
    switch (model.runtimeType) {
      case ProfileModel:
        break;

      case PostModel:
        _postRepo.addPost(model);
        break;

      default:
    }
  }
}
