import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';

class DataCategoryRepository {
  final ObjectBox _context;
  late final Box<DataCategory> _categoryBox;
  // final String _extractsFolder = locator.get<String>(instanceName: 'extracts_folder');

  DataCategoryRepository(this._context) {
    _categoryBox = _context.store.box<DataCategory>();
  }

  int updateCategory(DataCategory category) => _categoryBox.put(category);

  DataCategory getCategory(CategoryEnum category) {
    var entity = _categoryBox
        .query(DataCategory_.dbCategory.equals(category.index))
        .build()
        .findUnique();
    return entity ??
        _categoryBox
            .query(DataCategory_.dbCategory.equals(CategoryEnum.unknown.index))
            .build()
            .findUnique()!;
  }

  List<DataCategory> getAllCategories() {
    return _categoryBox.getAll();
  }

  void updateCounts() {
    var categories = _categoryBox.getAll();
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

  List<DataPointName> getNamesByCategory(DataCategory category) {
    var entity = _categoryBox.get(category.id)!;
    return entity.dataPointNames.toList();
  }

  DataCategory getFromFolderName(String folderName, ProfileDocument profile) {
    // get category from service based on parent directory for the file
    // keep looking backwards in the path until we reach root folder
    var categoryEnum = getFromPath(folderName);
    var existing = profile.categories
        .any((element) => element.dbCategory == categoryEnum.index);
    if (existing) {
      var category = profile.categories
          .singleWhere((element) => element.dbCategory == categoryEnum.index);
      return category;
    } else {
      var newCategory = DataCategory(
        matchingFoldersFacebook: [],
        matchingFoldersInstagram: [],
        category: categoryEnum,
      );
      int createdId = _categoryBox.put(newCategory);
      var createdCategory = _categoryBox.get(createdId)!;
      profile.categories.add(createdCategory);
      return createdCategory;
    }
  }

  int count() => _categoryBox.count();

  int addCategory(
    CategoryEnum category,
    List<String> matchingFoldersFacebook,
    List<String> matchingFoldersInstagram,
  ) {
    var existing = _categoryBox
        .query(DataCategory_.dbCategory.equals(category.index))
        .build()
        .findUnique();

    if (existing == null) {
      return _categoryBox.put(DataCategory(
        category: category,
        matchingFoldersFacebook: matchingFoldersFacebook,
        matchingFoldersInstagram: matchingFoldersInstagram,
      ));
    }

    return existing.id;
  }

  void addMany(List<DataCategory> categories) {
    _categoryBox.putMany(categories);
  }
}
