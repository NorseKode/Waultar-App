import 'package:waultar/core/inodes/tree_nodes.dart';

abstract class IUtilityRepository {
  /// Delete all created entities and returns total amount of entities deleted
  /// NOTE: will not delete services and categories
  int nukeAll();
  /// Returns total amount of images deleted
  int nukeAllImages();
  /// Returns total amount of videos deleted
  int nukeAllVideos();
  /// Returns total amount of files deleted
  /// This won't delete the actual file, just it's relation to a file
  int nukeAllFiles();
  /// Returns total amount of links deleted
  int nukeAllLinks();
  List<DataCategory> getAllCategories();
  int getTotalCountDataPoints();
  int getTotalCountDataNames();
  int getTotalCountCategories();
  int getTotalCountImages();
  int getTotalCountVideos();
  int getTotalCountFiles();
  int getTotalCountLinks();
}