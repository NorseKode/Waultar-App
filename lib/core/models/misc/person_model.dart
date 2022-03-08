import 'dart:ui';

import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class PersonModel extends BaseModel {
  final String name;
  Uri? uri;

  PersonModel(
      {int id = 0,
      required ProfileModel profile,
      required this.name,
      required String raw,
      this.uri})
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
