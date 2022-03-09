import 'package:waultar/core/abstracts/abstract_services/i_collections_service.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/inode.dart';

class CollectionsService implements ICollectionsService {

  final DataCategoryRepository _categoryRepository;
  final DataPointNameRepository _dataPointNameRepository;
  final DataPointRepository _dataPointRepository;

  CollectionsService(this._categoryRepository, this._dataPointNameRepository, this._dataPointRepository);

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