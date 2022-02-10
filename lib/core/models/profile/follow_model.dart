import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

import '../base_model.dart';

class FollowModel extends BaseModel {
  final PersonModel person;
  final FollowType followType;
  final DateTime timestamp;

  FollowModel(int id, ProfileModel profile, String raw, this.person,
      this.followType, this.timestamp)
      : super(id, profile, raw);
}

enum FollowType { unknown, follower, following }
