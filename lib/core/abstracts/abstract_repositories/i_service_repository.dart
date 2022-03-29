import 'package:waultar/data/entities/misc/service_document.dart';

abstract class IServiceRepository {
  ServiceDocument? get(String name);

  List<ServiceDocument> getAll();
}
