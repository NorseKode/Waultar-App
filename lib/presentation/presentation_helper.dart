import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_utility_repostitory.dart';
import 'package:waultar/startup.dart';

class PresentationHelper {
  static final IUtilityRepository _utilsRepo =
      locator.get<IUtilityRepository>(instanceName: 'utilsRepo');
  static final AppLogger _appLogger =
      locator.get<AppLogger>(instanceName: 'logger');

  static void logDatabase() {

    _appLogger.logger.info('DB log statistics:');
    _appLogger.logger.info('Total categories  -> ${_utilsRepo.getTotalCountCategories().toString()}');
    _appLogger.logger.info('Total name nodes  -> ${_utilsRepo.getTotalCountDataNames().toString()}');
    _appLogger.logger.info('Total datapoints  -> ${_utilsRepo.getTotalCountDataPoints().toString()}');
    _appLogger.logger.info('Total images      -> ${_utilsRepo.getTotalCountImages().toString()}');
    _appLogger.logger.info('Total videos      -> ${_utilsRepo.getTotalCountVideos().toString()}');
    _appLogger.logger.info('Total files       -> ${_utilsRepo.getTotalCountFiles().toString()}');
    _appLogger.logger.info('Total links       -> ${_utilsRepo.getTotalCountLinks().toString()}');
    _appLogger.logger.info('Category names and counts:');
    for (var category in _utilsRepo.getAllCategories()) {
      _appLogger.logger.info('${category.name} -> ${category.count}');
    }
  }

  static void nukeDatabase() {
    _appLogger.logger.info(
        "Entities deleted: " + _utilsRepo.nukeAll().toString());
    _appLogger.logger.info("Nuke database => removed all elements");
  }
}
