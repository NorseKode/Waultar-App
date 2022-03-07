import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class DataCategoryRepository {
  final ObjectBox _context;
  late final Box<DataCategory> _categoryBox;

  DataCategoryRepository(this._context) {
    _categoryBox = _context.store.box<DataCategory>();
  }

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
    var category = _categoryBox
        .query(DataCategory_.matchingFolders.contains(folderName))
        .build()
        .findFirst();

    if (category == null) {
      return _categoryBox
          .query(DataCategory_.name.equals("Other"))
          .build()
          .findUnique()!;
    }

    return category;
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
