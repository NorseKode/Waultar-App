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

  DataCategory? getCategoryById(int id) => _categoryBox.get(id);

  List<DataPointName>? getNamesByCategory(DataCategory category) {
    var entity = _categoryBox.get(category.id);
    if (entity != null) {
      return entity.dataPointNames.toList();
    }

    return null;
  }

  int count() => _categoryBox.count();

  int addCategory(String name) {
    var existing = _categoryBox
        .query(DataCategory_.name.equals(name))
        .build()
        .findUnique();
        
    if (existing == null) {
      return _categoryBox.put(DataCategory(name: name));
    }

    return existing.id;
  }
}
