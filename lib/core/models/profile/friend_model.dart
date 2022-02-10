import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class FriendModel extends BaseModel {
  final PersonModel friend;
  final FriendType friendType;
  final DateTime timestamp;

  FriendModel(int id, ProfileModel profile, String raw, this.friend,
      this.friendType, this.timestamp)
      : super(id, profile, raw);
}

enum FriendType { friend, deleted, rejected, sentRequest }
