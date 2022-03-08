import 'dart:ui';

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

  @override
  Color getAssociatedColor() {
    // TODO: implement getAssociatedColor
    throw UnimplementedError();
  }

  @override
  String getMostInformativeField() {
    // TODO: implement getMostInformativeField
    throw UnimplementedError();
  }

  @override
  DateTime getTimestamp() {
    // TODO: implement getTimestamp
    throw UnimplementedError();
  }
}

enum FollowType { unknown, follower, following }
