import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';

class DataCategoryRepository {
  final ObjectBox _context;
  late final Box<DataCategory> _categoryBox;

  DataCategoryRepository(this._context) {
    _categoryBox = _context.store.box<DataCategory>();
  }

  DataCategory updateCategory(DataCategory category) {
    try {
      int id = _categoryBox.put(category);
      return _categoryBox.get(id)!;
    } catch (e) {
      var existing = _categoryBox
          .query(DataCategory_.profileCategoryCombination
              .equals(category.profileCategoryCombination))
          .build()
          .findUnique()!;

      // ObjectBox do not have UPSERT operation so we have to perform it manually here
      // this means, updating all relations with the conflicting category relation
      var nameBox = _context.store.box<DataPointName>();
      var conflictingNames = nameBox.query(DataPointName_.dataCategory.equals(category.id)).build().find();
      for (var item in conflictingNames) {
        item.dataCategory.target = existing;
      }
      nameBox.putMany(conflictingNames);

      var dataBox = _context.store.box<DataPoint>();
      var conflictingDatapoints = dataBox.query(DataPoint_.category.equals(category.id)).build().find();
      for (var item in conflictingDatapoints) {
        item.category.target = existing;
      }
      dataBox.putMany(conflictingDatapoints);

      existing.dataPointNames.addAll(conflictingNames);

      int id = _categoryBox.put(existing);
      return _categoryBox.get(id)!;
    }
  }

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

  DataCategory? getCategoryById(int id) => _categoryBox.get(id);

  List<DataPointName> getNamesByCategory(DataCategory category) {
    var entity = _categoryBox.get(category.id)!;
    return entity.dataPointNames.toList();
  }

  DataCategory getFromFolderName(String folderName, ProfileDocument profile) {
    // get category from service based on parent directory for the file
    // keep looking backwards in the path until we reach root folder
    var categoryEnum = getFromPath(folderName);
    String uniqueIdentifier = profile.name + categoryEnum.categoryName;
    var existingBuilder = _categoryBox.query(
        DataCategory_.profileCategoryCombination.equals(uniqueIdentifier));
    var existingEntity = existingBuilder.build().findUnique();
    if (existingEntity != null) {
      return existingEntity;
    } else {
      var newCategory = DataCategory.create(
        categoryEnum,
        profile,
      );
      int createdId = 0;
      try {
        createdId = _categoryBox.put(newCategory);
      } catch (e) {
        createdId = _categoryBox
            .query(DataCategory_.profileCategoryCombination
                .equals(newCategory.profileCategoryCombination))
            .build()
            .findUnique()!
            .id;
      }

      var createdCategory = _categoryBox.get(createdId)!;
      
      profile.categories.add(createdCategory);
      return newCategory;
    }
  }

  int count() => _categoryBox.count();

  void addMany(List<DataCategory> categories) {
    _categoryBox.putMany(categories);
  }
}
