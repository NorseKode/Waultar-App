import 'dart:ui';

import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/misc/place_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class EventModel extends BaseModel {
  String name;
  DateTime? startTimestamp;
  DateTime? endTimestamp;
  DateTime? createdTimestamp;
  String? description;
  bool isUsers;
  PlaceModel? place;
  EventResponse? response;

  EventModel({
    int id = 0,
    required ProfileModel profile,
    required String raw,
    required this.name,
    this.startTimestamp,
    this.endTimestamp,
    this.createdTimestamp,
    this.description,
    required this.isUsers,
    this.place,
    this.response,
  }) : super(id, profile, raw);

  EventModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : name = json["name"],
        startTimestamp = ModelHelper.intToTimestamp(json["start_timestamp"]),
        endTimestamp = ModelHelper.intToTimestamp(json["end_timestamp"]),
        createdTimestamp = json.containsKey('create_timestamp')
            ? ModelHelper.intToTimestamp(json["create_timestamp"])
            : null,
        description =
            json.containsKey('description') ? json['description'] : null,
        isUsers = false,
        place = json.containsKey('place')
            ? PlaceModel.fromJson(json['place'], profile)
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

enum EventResponse { unknown, interested, joined, declined }
