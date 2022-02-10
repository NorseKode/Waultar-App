import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/service_model.dart';

class PersonModel extends BaseModel {
  late String name;
  String? uri;

  PersonModel(
      {int id = 0,
      required ServiceModel service,
      required String name,
      required String raw,
      String? uri})
      : super(id, service, raw);
}
