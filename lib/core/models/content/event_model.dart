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
        isUsers = true,
        super(0, profile, json.toString());
}

enum EventResponse {
  unknown,
  interested,
  joined,
  declined
}