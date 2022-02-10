import 'package:waultar/core/models/event_model.dart';
import 'package:waultar/core/models/group_model.dart';
import 'package:waultar/core/models/life_event_model.dart';
import 'package:waultar/core/models/media_model.dart';
import 'package:waultar/core/models/person_model.dart';
import 'package:waultar/core/models/poll_model.dart';
import 'package:waultar/core/models/service_model.dart';
import 'package:waultar/core/models/tag_model.dart';

import 'base_model.dart';

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
    required this.timestamp,
    required String raw,
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

  // PostModel.fromJson(Map<String, dynamic> json)
  //     : id = null,
  //       content = null,
  //       description = json["post"],
  //       title = json["title"],
  //       // event = null,
  //       // group = null,
  //       // poll = null,
  //       // lifeEventType = null
  //       timestamp = DateTime.fromMillisecondsSinceEpoch(json["timestamp"]);

  @override
  String toString() {
    return "Title: $title, description: $description, timestamp: ${timestamp.toString()}";
  }
}
