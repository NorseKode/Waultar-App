import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:path/path.dart' as path_dart;

class DataCategoryRepository {
  final ObjectBox _context;
  late final Box<DataCategory> _categoryBox;

  DataCategoryRepository(this._context) {
    _categoryBox = _context.store.box<DataCategory>();
  }

  int updateCategory(DataCategory category) => _categoryBox.put(category);

  DataCategory? getCategoryByName(String name) {
    var category = _categoryBox
        .query(DataCategory_.name.equals(name))
        .build()
        .findUnique();
    return category;
  }

  List<DataCategory> getAllCategories() {
    return _categoryBox.getAll();
  }

  void updateCounts() {
    var categories = _categoryBox.getAll();
    var totalDataPoints = _context.store.box<DataPoint>().count();
    print(totalDataPoints);
    for (var category in categories) {
      var builder = _context.store.box<DataPoint>().query();
      builder.link(DataPoint_.category, DataCategory_.id.equals(category.id));
      category.count = builder.build().count();
    }
    _categoryBox.putMany(categories);
  }

  List<DataPointName> getNamesFromCategory(DataCategory category) {
    return _categoryBox.get(category.id)!.dataPointNames.toList();
  }

  void updateCount(DataCategory category, int incrementWith) {
    var entity = _categoryBox.get(category.id)!;
    entity.count += incrementWith;
    _categoryBox.put(entity);
  }

  DataCategory? getCategoryById(int id) => _categoryBox.get(id);

  List<DataPointName>? getNamesByCategory(DataCategory category) {
    var entity = _categoryBox.get(category.id);
    if (entity != null) {
      return entity.dataPointNames.toList();
    }

    return null;
  }

  DataCategory getFromFolderName(String folderName) {
    // get category from service based on parent directory for the file
    // keep looking backwards in the path until we reach root folder

    // might result in stackOverflow if root folder is not Facebook or Instagram
    try {
      var name = path_dart.basename(folderName);

      // if still none are found, set category to "Other" (default)
      if (name == "Facebook" || name == "Instagram") {
        return _categoryBox
            .query(DataCategory_.name.equals("Other"))
            .build()
            .findUnique()!;
      }

      var category = _categoryBox
          .query(DataCategory_.matchingFolders.contains(name))
          .build()
          .findFirst();

      // if none is found :
      if (category == null) {
        return getFromFolderName(
            folderName.substring(0, folderName.length - name.length));
      } else {
        return category;
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
      return _categoryBox
          .query(DataCategory_.name.equals("Other"))
          .build()
          .findUnique()!;
    }
  }

  int count() => _categoryBox.count();

  int addCategory(String name, List<String> matchingFolders) {
    var existing = _categoryBox
        .query(DataCategory_.name.equals(name))
        .build()
        .findUnique();

    if (existing == null) {
      return _categoryBox
          .put(DataCategory(name: name, matchingFolders: matchingFolders));
    }

    return existing.id;
  }

  void addMany(List<DataCategory> categories) {
    _categoryBox.putMany(categories);
  }
}
