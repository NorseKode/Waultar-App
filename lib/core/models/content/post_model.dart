import 'package:waultar/core/models/content/event_model.dart';
import 'package:waultar/core/models/content/group_model.dart';
import 'package:waultar/core/models/content/life_event_model.dart';
import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/core/models/content/poll_model.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/models/misc/tag_model.dart';

import '../base_model.dart';

class PostModel extends BaseModel {
  late DateTime timestamp;

  // facebook and instagram
  List<MediaModel>? content;
  String? description;
  String? title;

  List<PersonModel>? mentions;
  List<TagModel>? tags;

  // only for facebook
  EventModel? event;
  GroupModel? group;
  PollModel? poll;
  LifeEventModel? lifeEvent;

  // only for instagram
  bool? isArchived;

  // meta should be misc/other
  String? meta;

  PostModel({
    int id = 0,
    required ServiceModel service,
    required String raw,
    required this.timestamp,
    this.content,
    this.description,
    this.title,
    this.mentions,
    this.tags,
    this.event,
    this.group,
    this.poll,
    this.lifeEvent,
    this.isArchived = false,
    this.meta,
  }) : super(id, service, raw);

  PostModel.fromJson(Map<String, dynamic> json, ServiceModel service)
      : content = null,
        description = json["post"],
        title = json["title"],
        event = null,
        group = null,
        poll = null,
        lifeEvent = null,
        timestamp = DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
        super (0, service, "");

  @override
  String toString() {
    return "Title: $title, description: $description, timestamp: ${timestamp.toString()}";
  }
}
