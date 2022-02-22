import 'package:waultar/core/abstracts/abstract_repositories/i_group_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';
import 'package:waultar/startup.dart';

class ParserService implements IParserService {
  final IPostRepository _postRepo =
      locator.get<IPostRepository>(instanceName: 'postRepo');
  final IProfileRepository _profileRepo =
      locator.get<IProfileRepository>(instanceName: 'profileRepo');
  final IGroupRepository _groupRepo =
      locator.get<IGroupRepository>(instanceName: 'groupRepo');

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

        var groupsAndPaths = await parser.parseGroupNames(paths, profileModel);
        var groups = groupsAndPaths.item1;
        _groupRepo.addMany(groups);

        // profile_information.json has now been removed
        paths = groupsAndPaths.item2;

        await for (final entity in FacebookParser()
            .parseListOfPaths(paths, profile: profileModel)) {
          _makeEntity(entity);
        }
        break;

      case "Instagram":
        var parser = InstagramParser();

        var profileAndPaths =
            await parser.parseProfile(paths, service: service);
        var profile = profileAndPaths.item1;
        paths = profileAndPaths.item2;

        var tempId = _makeEntity(profile);
        var profileModel = _profileRepo.getProfileById(tempId);

        await for (final entity
            in parser.parseListOfPaths(paths, profile: profileModel)) {
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

      case GroupModel:
        return _groupRepo.updateGroup(model);

        
      default:
        return -1;
    }
  }
}
