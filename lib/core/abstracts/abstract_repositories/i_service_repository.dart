import 'package:waultar/core/models/misc/service_model.dart';

abstract class IServiceRepository {
  ServiceModel? get(String name);

  List<ServiceModel> getAll();
}
