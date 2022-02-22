import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_file_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_image_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_link_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_video_repository.dart';
import 'package:waultar/startup.dart';

class PresentationHelper {
  static final IProfileRepository _profileRepo =
      locator.get<IProfileRepository>(instanceName: 'profileRepo');
  static final IPostRepository _postRepo = locator.get<IPostRepository>(instanceName: 'postRepo');
  static final ILinkRepository _linkRepo = locator.get<ILinkRepository>(instanceName: 'linkRepo');
  static final AppLogger _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  static void logDatabase() {
    var profiles = _profileRepo.getAllProfiles();
    var posts = _postRepo.getAllPosts();
    var links = _linkRepo.getAllLinks();

    for (var profile in profiles) {
      _appLogger.logger.info("Profile: ${profile.toString()}");
    }

    if (posts != null) {
      for (var post in posts) {
        _appLogger.logger.info("Post: ${post.toString()}");
      }
    }

    if (links != null) {
      for (var link in links) {
        _appLogger.logger.info("Post: ${link.toString()}");
      }
    }

    _appLogger.logger.info("Found ${profiles.length} profiles in the database");
    if (links != null) {
      _appLogger.logger.info("Found ${links.length} links in the database");
    }
    if (posts != null) {
      _appLogger.logger.info("Found ${posts.length} posts in the database");
    }
  }

  static void nukeDatabase() {
    _appLogger.logger.info("Profiles deleted: " + _profileRepo.removeAllProfiles().toString());
    _appLogger.logger.info("Posts deleted: " + _postRepo.removeAllPosts().toString());
    _appLogger.logger.info("Images deleted: " +
        (locator.get<IImageRepository>(instanceName: 'imageRepo')).removeAll().toString());
    _appLogger.logger.info("Videos deleted: " +
        (locator.get<IVideoRepository>(instanceName: 'videoRepo')).removeAll().toString());
    _appLogger.logger.info("Posts deleted: " +
        (locator.get<IFileRepository>(instanceName: 'fileRepo').removeAll()).toString());
    _appLogger.logger.info("Posts deleted: " +
        (locator.get<ILinkRepository>(instanceName: 'linkRepo').removeAll()).toString());

    _appLogger.logger.info("Nuke database => removed all elements");
  }
}
