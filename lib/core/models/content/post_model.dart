import 'package:waultar/core/models/content/event_model.dart';
import 'package:waultar/core/models/content/group_model.dart';
import 'package:waultar/core/models/content/life_event_model.dart';
import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/core/models/content/poll_model.dart';
import 'package:waultar/core/models/misc/tag_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

import '../../parsers/parse_helper.dart';
import '../base_model.dart';
import '../model_helper.dart';

class PostModel extends BaseModel {
  DateTime timestamp;

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
    required ProfileModel profile,
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
  }) : super(id, profile, raw);

  PostModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : timestamp = DateTime.fromMicrosecondsSinceEpoch(0),
        super(0, profile, json.toString()) {
    dynamic eventJson;
    // ignore: unused_local_variable
    dynamic pollJson;
    var mediaJson = <dynamic>[];
    dynamic attachments;
    dynamic data;

    if (json.keys.length == 1 && json.containsKey("media")) {
      json = json["media"].first;
    }

    if (json.containsKey("attachments") && json["attachments"].isNotEmpty) {
      attachments = json["attachments"].firstWhere(
          (element) => element is Map<String, dynamic> && element.containsKey("data"),
          orElse: null);
    }

    if (json.containsKey("data") && json["data"].isNotEmpty) {
      data = json["data"].isNotEmpty
          ? json["data"].firstWhere((element) => element is Map<String, dynamic>, orElse: null)
          : null;
    }

    if (attachments != null) {
      for (var item in attachments["data"]) {
        if (item is Map<String, dynamic>) {
          if (item.containsKey("event")) {
            eventJson = item["event"];
          } else if (item.containsKey("poll")) {
            pollJson = item;
          } else if (item.values.contains("uri")) {
            mediaJson.add(item);
          }
        }
      }
    }

    content = mediaJson.map((element) => ParseHelper.parseMedia(element, "media")!).toList();
    description = json["title"] ?? "";
    title = data != null ? data["post"] : "";
    event = eventJson != null ? EventModel.fromJson(eventJson, profile) : null;
    group = null; //TODO: group post
    poll = null; //TODO: poll post
    lifeEvent = null; //TODO: lifeevent
    timestamp = ModelHelper.getTimestamp(json)!;
  }

  @override
  String toString() {
    return "Title: $title, description: $description, timestamp: ${timestamp.toString()}";
  }
}
