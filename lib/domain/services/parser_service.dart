import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_comment_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_event_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_group_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_image_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_poll_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/models/content/post_poll_model.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';
import 'package:waultar/startup.dart';

class ParserService implements IParserService {
  // final _serviceRepo = locator.get<IServiceRepository>(instanceName: 'serviceRepo');
  final IPostRepository _postRepo = locator.get<IPostRepository>(instanceName: 'postRepo');
  final IProfileRepository _profileRepo =
      locator.get<IProfileRepository>(instanceName: 'profileRepo');
  final IGroupRepository _groupRepo = locator.get<IGroupRepository>(instanceName: 'groupRepo');
  final IEventRepository _eventRepo = locator.get<IEventRepository>(instanceName: 'eventRepo');
  final IPostPollRepository _postPollRepo =
      locator.get<IPostPollRepository>(instanceName: 'postPollRepo');
  final IImageRepository _imageRepo = locator.get<IImageRepository>(instanceName: 'imageRepo');
  final ICommentRepository _commentRepo =
      locator.get<ICommentRepository>(instanceName: 'commentRepo');
  final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  @override
  Future parseAll(List<String> paths, ServiceModel service) async {
    _appLogger.logger.info("Started parsing of files started");
    switch (service.name) {
      case "Facebook":
        var parser = FacebookParser();

        var profileAndPaths = await parser.parseProfile(paths, service: service);
        var profile = profileAndPaths.item1;
        paths = profileAndPaths.item2;

        var tempId = _makeEntity(profile);
        var profileModel = _profileRepo.getProfileById(tempId);

        var groupsAndPaths = await parser.parseGroupNames(paths, profileModel);
        var groups = groupsAndPaths.item1;
        if (groups.isNotEmpty) {
          _groupRepo.addMany(groups);
        }

        // profile_information.json has now been removed
        paths = groupsAndPaths.item2;

        await for (final entity in FacebookParser().parseListOfPaths(paths, profileModel)) {
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

        await for (final entity in parser.parseListOfPaths(paths, profileModel)) {
          _makeEntity(entity);
        }

        _appLogger.logger.info("Finished parsing of files started");

        // tag all images
        locator.get<IMLService>(instanceName: 'mlService').classifyImagesFromDB();

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

      case EventModel:
        return _eventRepo.addEvent(model);

      case PostPollModel:
        return _postPollRepo.addPostPoll(model);

      case CommentModel:
        return _commentRepo.add(model);

      case ImageModel:
        return _imageRepo.addImage(model);

      default:
        return -1;
    }
  }
}
