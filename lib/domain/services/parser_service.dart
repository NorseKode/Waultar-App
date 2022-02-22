import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';
import 'package:waultar/startup.dart';

class ParserService implements IParserService {
  final IPostRepository _postRepo = locator.get<IPostRepository>(instanceName: 'postRepo');
  final IProfileRepository _profileRepo =
      locator.get<IProfileRepository>(instanceName: 'profileRepo');
  final IServiceRepository _serviceRepo = locator.get<IServiceRepository>(instanceName: 'serviceRepo');

  @override
  Future parseAll(List<String> paths, ServiceModel service) async {
    switch (service.name) {
      case "Facebook":
        var parser = FacebookParser();

        var profileAndPaths = await parser.parseProfile(paths);
        var profile = profileAndPaths.item1;
        paths = profileAndPaths.item2;

        var tempId = _makeEntity(profile);
        var profileModel = _profileRepo.getProfileById(tempId);

        await for (final entity in FacebookParser().parseListOfPaths(paths, profile: profileModel)) {
          _makeEntity(entity);
        }
        break;

      case "Instagram":
        var parser = InstagramParser();

        var profileAndPaths = await parser.parseProfile(paths, service: service);
        var profile = profileAndPaths.item1;
        paths = profileAndPaths.item2;

        var tempId = _makeEntity(profile);
        var profileModel = _profileRepo.getProfileById(tempId);

        await for (final entity in parser.parseListOfPaths(paths, profile: profileModel)) {
          _makeEntity(entity);
        }
        break;

      default:
    }
  }

  int _makeEntity(dynamic model) {
    switch (model.runtimeType) {
      case ProfileModel:
        return _profileRepo.addProfile(model);

      case PostModel:
        return _postRepo.addPost(model);

      default:
        return -1;
    }
  }
}
