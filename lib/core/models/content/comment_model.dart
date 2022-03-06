import 'dart:ui';

import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/core/models/misc/reaction_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/startup.dart';

import '../base_model.dart';
import 'group_model.dart';

class CommentModel extends BaseModel {
  late PersonModel commenter;
  late String text;
  DateTime timestamp;
  List<MediaModel>? media;
  GroupModel? group;
  ReactionModel? reaction;
  final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  CommentModel(int id, ProfileModel profile, String raw, this.commenter, this.text, this.timestamp,
      this.media, this.group, this.reaction)
      : super(id, profile, raw);

  static const _instagramKey = "string_list_data";

  CommentModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : commenter = PersonModel(profile: profile, name: "name", raw: ""),
        timestamp = json.containsKey(_instagramKey)
            ? ModelHelper.intToTimestamp(((json[_instagramKey]).first)["timestamp"]) ??
                DateTime.fromMicrosecondsSinceEpoch(0)
            : DateTime.fromMillisecondsSinceEpoch(0),
        text = json.containsKey(_instagramKey) ? ((json[_instagramKey]).first)["value"] : "",
        super(0, profile, json.toString());

  CommentModel.fromFacebook(Map<String, dynamic> json, ProfileModel profile)
      : timestamp = ModelHelper.intToTimestamp(json["timestamp"])!,
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
        group = GroupModel(id: 0, profile: profile, raw: "raw", name: data["group"]);
      }
    }

    if (json["attachments"] is List<dynamic> && json["attachments"].length == 1) {
      var attachments = (((json["attachments"]).first)["data"]).first;
      var possibleMedia = ParseHelper.parseMediaNoKnownKey(attachments, profile);

      if (possibleMedia != null) {
        media = [possibleMedia];
      }
    }

    var exp = RegExp(r"(\w.+)((?:commented on )|(?:replied to ))(\w.+)'s");
    var match = exp.firstMatch(json["title"]);
    commenter = PersonModel(
      id: 0,
      name: match != null ? match.group(3)! : 'name',
      profile: profile,
      raw: '',
    );
  }

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
