import 'dart:io';

import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
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

  @override
  Future parseAll(List<String> paths, ServiceModel service) async {
    switch (service.name) {
      case "Facebook":
        await for (final entity in FacebookParser().parseListOfPaths(paths)) {
          _makeEntity(entity);
        }
        break;

      case "Instagram":
        var parser = InstagramParser();

        var profilePath =
            paths.firstWhere((element) => element.contains("personal_information.json"));
        paths.remove(profilePath);

        var profile = (await parser.parseFile(File(profilePath)).toList()).first;
        var tempId = _makeEntity(profile);
        var profileModel = _profileRepo.getProfileById(tempId);

        parser.setProfile(profileModel);

        await for (final entity in parser.parseListOfPaths(paths)) {
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
