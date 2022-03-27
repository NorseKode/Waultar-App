import 'package:waultar/core/inodes/service_document.dart';

abstract class IServiceRepository {
  ServiceDocument? get(String name);

  List<ServiceDocument> getAll();
}
