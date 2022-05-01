import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_dashboard_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_explorer_service.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';
import 'package:waultar/data/entities/timebuckets/day_bucket.dart';
import 'package:waultar/data/entities/timebuckets/weekday_average_bucket.dart';
import 'package:waultar/data/entities/timebuckets/year_bucket.dart';
import 'package:waultar/data/repositories/buckets_repo.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_name_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/repositories/profile_repo.dart';

class ExplorerService implements IExplorerService {
  final ProfileRepository _profileRepository;
  final DataCategoryRepository _categoryRepository;
  final DataPointNameRepository _dataPointNameRepository;
  final DataPointRepository _dataPointRepository;

  ExplorerService(this._profileRepository, this._categoryRepository,
      this._dataPointNameRepository, this._dataPointRepository);

  @override
  List<ProfileDocument> getAllProfiles() {
    return _profileRepository.getAll();
  }

  @override
  List<DataCategory> getAllCategories(int profileID) {
    return _profileRepository.get(profileID)!.categories;
  }

  @override
  List<DataPointName> getAllDatanames(int categoryID) {
    return _categoryRepository
        .getNamesByCategory(_categoryRepository.getCategoryById(categoryID)!);
  }

  @override
  List<DataPoint> getAllDataPoints(int datapointnameID) {
    return _dataPointNameRepository.getNameById(datapointnameID)!.dataPoints;
  }

  @override
  List<DataPointName> getAllDatanameChildren(int datanameID) {
    return _dataPointNameRepository.getNameById(datanameID)!.children;
  }
}
