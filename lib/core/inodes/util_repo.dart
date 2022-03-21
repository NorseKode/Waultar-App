import 'package:waultar/core/abstracts/abstract_repositories/i_utility_repostitory.dart';
import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/data/configs/objectbox.dart';

class UtilityRepository implements IUtilityRepository {

  final ObjectBox _context;
  UtilityRepository(this._context);

  @override
  int nukeAll() {
    int removed = 0;
    removed += nukeAllVideos();
    removed += nukeAllImages();
    removed += nukeAllFiles();
    removed += nukeAllLinks();
    removed += _nukeAllDataPoints();
    removed += _nukeAllNames();

    return removed;
  }

  int _nukeAllDataPoints() => _context.store.box<DataPoint>().removeAll();
  int _nukeAllNames() => _context.store.box<DataPointName>().removeAll();

  @override
  int nukeAllFiles() => _context.store.box<FileDocument>().removeAll();

  @override
  int nukeAllImages() => _context.store.box<ImageDocument>().removeAll();

  @override
  int nukeAllLinks() => _context.store.box<LinkDocument>().removeAll();
  
  @override
  int nukeAllVideos() => _context.store.box<VideoDocument>().removeAll();
  

  void _resetCounts() {
    // TODO - imlement with a single transaction. 
    // should reset all computed values, which includes :
    // - service counts
    // - category counts
    // - timebucket counts
  }

  @override
  List<DataCategory> getAllCategories() => _context.store.box<DataCategory>().getAll();

  @override
  int getTotalCountCategories() => _context.store.box<DataCategory>().count();

  @override
  int getTotalCountDataNames() => _context.store.box<DataPointName>().count();

  @override
  int getTotalCountDataPoints() => _context.store.box<DataPoint>().count();

  @override
  int getTotalCountFiles() => _context.store.box<FileDocument>().count();

  @override
  int getTotalCountImages() => _context.store.box<ImageDocument>().count();

  @override
  int getTotalCountLinks() => _context.store.box<LinkDocument>().count();

  @override
  int getTotalCountVideos() => _context.store.box<VideoDocument>().count();
    
}