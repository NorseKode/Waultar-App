import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/place_model.dart';
import 'package:waultar/core/models/service_model.dart';

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
    required ServiceModel service,
    required String raw,
    required this.name,
    this.startTimestamp,
    this.endTimestamp,
    this.createdTimestamp,
    this.description,
    required this.isUsers,
    this.place,
    this.response,
  }) : super(id, service, raw);
}

enum EventResponse {
  interested,
  joined,
  declined
}
