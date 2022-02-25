import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/content/event_model.dart';
import 'package:waultar/data/entities/misc/place_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class EventObjectBox {
  int id;
  final profile = ToOne<ProfileObjectBox>();
  String raw;
  String name;

  @Property(type: PropertyType.date)
  DateTime? startTimestamp;

  @Property(type: PropertyType.date)
  DateTime? endTimestamp;

  @Property(type: PropertyType.date)
  DateTime? createdTimestamp;
  
  String? description;
  bool isUsers;
  final place = ToOne<PlaceObjectBox>();
  EventResponse? response;

  int? get dbEventResponse {
    _ensureStableEnumValue();
    return response?.index;
  }

  set dbEventResponse (int? value) {
    _ensureStableEnumValue();
    if (value == null) {
      response = null;
    } else {
      response = value >= 0 && value < EventResponse.values.length
        ? EventResponse.values[value]
        : EventResponse.unknown;
    }
  }

  EventObjectBox({
    this.id = 0, 
    required this.raw,
    required this.name,
    this.startTimestamp,
    this.endTimestamp,
    this.createdTimestamp,
    this.description,
    required this.isUsers,
    this.response,
  });

  void _ensureStableEnumValue() {
    assert(EventResponse.unknown.index == 0);
    assert(EventResponse.interested.index == 1);
    assert(EventResponse.joined.index == 2);
    assert(EventResponse.declined.index == 3);
  }
}