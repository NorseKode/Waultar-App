import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class ServiceRepository implements IServiceRepository {
  final ObjectBox _context;
  late final Box<ServiceDocument> _serviceBox;
  ServiceRepository(this._context) {
    _serviceBox = _context.store.box<ServiceDocument>();
  }

  @override
  ServiceModel? get(String name) {
    var service = _serviceBox
        .query(ServiceDocument_.serviceName.equals(name))
        .build()
        .findUnique();
    if (service != null) {
      return ServiceModel(
        name: service.serviceName,
        company: service.companyName,
        image: Uri(path: service.image),
        id: service.id,
      );
    } else {
      return null;
    }
  }

  @override
  List<ServiceModel> getAll() {
    return _serviceBox
        .getAll()
        .map(
          (s) => ServiceModel(
            name: s.serviceName,
            company: s.companyName,
            image: Uri(path: s.image),
            id: s.id,
          ),
        )
        .toList();
  }
}
