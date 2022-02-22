import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/startup.dart';

class PresentationHelper {
  static final IProfileRepository _profileRepo = locator.get<IProfileRepository>(instanceName: 'profileRepo');
  static final IPostRepository _postRepo = locator.get<IPostRepository>(instanceName: 'postRepo');
  static final AppLogger _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  static void logDatabase() {
    var profiles = _profileRepo.getAllProfiles();
    var posts = _postRepo.getAllPosts();

    for (var profile in profiles) {
    _appLogger.logger.info("Profile: ${profile.toString()}");
    }

    for (var post in posts) {
    _appLogger.logger.info("Post: ${post.toString()}");
    }
    
    _appLogger.logger.info("Found ${profiles.length} profiles in the database");
    _appLogger.logger.info("Found ${posts.length} profiles in the database");
  }

  static void nukeDatabase() {
    var results = <int>[];
    results.add(_profileRepo.removeAllProfiles());
    results.add(_postRepo.removeAllPosts());

    _appLogger.logger.info("Nuke database => removed all elements");
  }
}