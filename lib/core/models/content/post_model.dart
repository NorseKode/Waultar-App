import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

class PostModel extends BaseModel {
  DateTime timestamp;
  String? description;
  String? title;
  List<MediaModel>? medias;
  List<TagModel>? tags;
  List<PersonModel>? mentions;
  bool? isArchived;
  String? metadata;

  PostModel({
    int id = 0,
    required ProfileModel profile,
    required String raw,
    required this.timestamp,
    this.title,
    this.description,
    this.medias,
    this.tags,
    this.mentions,
    this.isArchived,
    this.metadata
  }) : super(id, profile, raw);

  PostModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : timestamp = DateTime.fromMicrosecondsSinceEpoch(0),
        super(0, profile, json.toString()) {
    // ignore: unused_local_variable
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

    medias = mediaJson.map((element) => ParseHelper.parseMedia(element, "media")!).toList();
    description = json["title"] ?? "";
    title = data != null ? data["post"] : "";
    // event = eventJson != null ? EventModel.fromJson(eventJson, profile) : null;
    timestamp = ModelHelper.getTimestamp(json)!;
  }

  @override
  String toString() {
    return "Title: $title, description: $description, timestamp: ${timestamp.toString()}";
  }
}
