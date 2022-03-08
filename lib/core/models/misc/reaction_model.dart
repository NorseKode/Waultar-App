import 'dart:ui';

import 'package:waultar/core/models/profile/profile_model.dart';

import '../base_model.dart';

class ReactionModel extends BaseModel {
  final String reaction;

  ReactionModel(int id, ProfileModel profile, String raw, this.reaction)
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
