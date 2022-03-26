import 'package:flutter/material.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/models/content/event_model.dart';
import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/startup.dart';

import '../base_model.dart';
import 'group_model.dart';

class CommentModel extends BaseModel {
  late PersonModel commented;
  late String text;
  DateTime timestamp;
  List<MediaModel>? media;
  GroupModel? group;
  EventModel? event;
  // ReactionModel? reaction;
  final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  CommentModel(
      {int id = 0,
      required ProfileModel profile,
      required String raw,
      required this.commented,
      required this.text,
      required this.timestamp,
      this.media,
      this.group,
      this.event})
      : super(id, profile, raw);

  static const _instagramKey = "string_list_data";

  CommentModel.fromInstagram(Map<String, dynamic> json, ProfileModel profile)
      : commented = PersonModel(profile: profile, name: json["title"], raw: ""),
        timestamp = json.containsKey(_instagramKey)
            ? ModelHelper.intToTimestamp(
                    ((json[_instagramKey]).first)["timestamp"])
            : DateTime.fromMillisecondsSinceEpoch(0),
        text = json.containsKey(_instagramKey)
            ? ((json[_instagramKey]).first)["value"]
            : "",
        super(0, profile, json.toString());

  CommentModel.fromFacebook(Map<String, dynamic> json, ProfileModel profile)
      : timestamp = ModelHelper.intToTimestamp(json["timestamp"]),
        super(0, profile, json.toString()) {
    var temp = (json["data"]);
    if (temp is List<dynamic> && temp.length > 1) {
      _appLogger.logger.shout("data list in comment greater than 1");
    }

    temp = json["attachments"];
    if (temp is List<dynamic> && temp.length > 1) {
      _appLogger.logger.shout("attachments list in comment greater than 1");
    }

    if (json["data"] is List<dynamic> && json["data"].length == 1) {
      var data = ((json["data"]).first)["comment"];
      text = data["comment"];
      if (data.containsKey("group")) {
        group = GroupModel(
            id: 0, profile: profile, raw: "raw", name: data["group"]);
      }
    } else {
      text = "";
    }

    if (json["attachments"] is List<dynamic> &&
        json["attachments"].length == 1) {
      var attachments = (((json["attachments"]).first)["data"]).first;
      if (attachments.containsKey("event")) {
        event = EventModel.fromJson(attachments["event"], profile);
      } else {
        var possibleMedia =
            ParseHelper.parseMediaNoKnownKey(attachments, profile);

        if (possibleMedia != null) {
          media = [possibleMedia];
        }
      }
    }

    String personText = json["title"];
    var exp = personText.contains(" own ")
        ? RegExp(r"(\w.+)((?:commented on )|(?:replied to ))(\w.+)")
        : RegExp(r"(\w.+)((?:commented on )|(?:replied to ))(\w.+)'s");
    var match = exp.firstMatch(personText);
    commented = PersonModel(
      id: 0,
      name: match != null
          ? personText.contains(" own ")
              ? match.group(1)!.trimRight()
              : match.group(3)!
          : "TODO: localization", //throw Tuple2("Couldn't find a name to a comment", json.toString()),
      profile: profile,
      raw: '',
    );
  }

  @override
  String toString() {
    return "Commented: ${commented.name}, Text: $text, Timestamp: ${timestamp.toString()}, Group: ${group.toString()}";
  }

  @override
  Color getAssociatedColor() {
    return Colors.indigo;
  }

  @override
  String getMostInformativeField() {
    return text;
  }

  @override
  DateTime getTimestamp() {
    return timestamp;
  }
}
