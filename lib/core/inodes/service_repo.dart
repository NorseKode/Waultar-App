import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class ServiceRepository implements IServiceRepository {
  final ObjectBox _context;
  late final Box<ServiceDocument> _serviceBox;
  ServiceRepository(this._context) {
    _serviceBox = _context.store.box<ServiceDocument>();
  }

  @override
  ServiceDocument? get(String name) {
    return _serviceBox
        .query(ServiceDocument_.serviceName.equals(name))
        .build()
        .findUnique();
  }

  @override
  List<ServiceDocument> getAll() {
    return _serviceBox.getAll();
  }
}
