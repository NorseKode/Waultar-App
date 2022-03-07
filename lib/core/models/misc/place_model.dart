import 'dart:ui';

import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/misc/coordinate_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class PlaceModel extends BaseModel {
  String name;
  String? address;
  CoordinateModel? coordinate;
  Uri? uri;

  PlaceModel(
      {int id = 0,
      required ProfileModel profile,
      required String raw,
      required this.name,
      this.address,
      this.coordinate,
      this.uri})
      : super(id, profile, raw);

  PlaceModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : name = json['name'],
        address = json.containsKey('address') ? json['address'] : null,
        uri = json.containsKey('uri') ? Uri(path: json['url']) : null,
        coordinate = json.containsKey('coordinate')
            ? CoordinateModel.fromJson(json['coordinate'])
            : null,
        super(0, profile, json.toString());

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
