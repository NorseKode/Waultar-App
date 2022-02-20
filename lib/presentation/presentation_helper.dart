import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/startup.dart';

class PresentationHelper {
  static final IProfileRepository _profileRepo = locator.get<IProfileRepository>(instanceName: 'profileRepo');
  static final IPostRepository _postRepo = locator.get<IPostRepository>(instanceName: 'postRepo');
  static final AppLogger _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  static void logDatabase() {
    var _profiles = _profileRepo.getAllProfiles();
    var _posts = _postRepo.getAllPosts();

    _profiles.forEach((e) => _appLogger.logger.info("Profile: ${e.toString()}"));
    _posts.forEach((e) => _appLogger.logger.info("Post: ${e.toString()}"));

    _appLogger.logger.info("Found ${_profiles.length} profiles in the database");
    _appLogger.logger.info("Found ${_posts.length} profiles in the database");
  }

  static void nukeDatabase() {
    var results = <int>[];
    results.add(_profileRepo.removeAllProfiles());
    results.add(_postRepo.removeAllPosts());

    _appLogger.logger.info("Nuke database => removed all elements");
  }
}