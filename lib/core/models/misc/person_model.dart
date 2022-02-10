import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class PersonModel extends BaseModel {
  late String name;
  String? uri;

  PersonModel(
      {int id = 0,
      required ProfileModel profile,
      required String name,
      required String raw,
      String? uri})
      : super(id, profile, raw);
}
