import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';

ServiceModel makeServiceModel(ServiceObjectBox entity) {
  var modelToReturn = ServiceModel(
      id: entity.id,
      name: entity.name,
      company: entity.company,
      image: Uri(path: entity.image));

  return modelToReturn;
}
