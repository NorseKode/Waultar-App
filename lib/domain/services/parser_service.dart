import 'dart:io';

import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';
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
  final IProfileRepository _profileRepo =
      locator.get<IProfileRepository>(instanceName: 'profileRepo');
  final IServiceRepository _serviceRepo = locator.get<IServiceRepository>(instanceName: 'serviceRepo');

  @override
  Future parseAll(List<String> paths, ServiceModel service) async {
    switch (service.name) {
      case "Facebook":
        await for (final entity in FacebookParser().parseListOfPaths(paths)) {
          _makeEntity(entity);
        }
        break;

      case "Instagram":
        var service = _serviceRepo.get('Instagram');
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

    return 1;
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
