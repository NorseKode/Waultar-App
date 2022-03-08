import 'dart:ui';

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

enum FriendType { unknown, friend, deleted, rejected, sentRequest }
