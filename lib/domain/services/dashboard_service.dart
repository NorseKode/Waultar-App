import 'package:tuple/tuple.dart';
import 'package:waultar/core/abstracts/abstract_services/i_dashboard_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/data_category_repo.dart';
import 'package:waultar/data/repositories/datapoint_name_repo.dart';
import 'package:waultar/data/repositories/datapoint_repo.dart';
import 'package:waultar/data/repositories/profile_repo.dart';

class DashboardService implements IDashboardService {
  final ProfileRepository _profileRepository;
  final DataCategoryRepository _categoryRepository;
  final DataPointNameRepository _dataPointNameRepository;
  final DataPointRepository _dataPointRepository;

  DashboardService(this._profileRepository, this._categoryRepository,
      this._dataPointNameRepository, this._dataPointRepository);

  @override
  List<ProfileDocument> getAllProfiles() {
    return _profileRepository.getAll();
  }

  @override
  List<Tuple2<String, int>> getSortedMessageCount(int? numberOfPeople) {
    return [];
  }
}
