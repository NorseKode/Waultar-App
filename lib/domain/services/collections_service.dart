import 'package:waultar/core/abstracts/abstract_services/i_collections_service.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_name_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';

class CollectionsService implements ICollectionsService {
  final DataCategoryRepository _categoryRepository;
  final DataPointNameRepository _dataPointNameRepository;
  // ignore: unused_field
  final DataPointRepository _dataPointRepository;

  CollectionsService(this._categoryRepository, this._dataPointNameRepository,
      this._dataPointRepository);

  @override
  List<DataCategory> getAllCategories() {
    return _categoryRepository.getAllCategories();
  }

  @override
  List<DataPoint> getAllDataPointsFromName(DataPointName name) {
    return _dataPointNameRepository.getDataPointsByName(name);
  }

  @override
  List<DataPointName> getAllNamesFromCategory(DataCategory category) {
    return _categoryRepository.getNamesFromCategory(category);
  }
}
