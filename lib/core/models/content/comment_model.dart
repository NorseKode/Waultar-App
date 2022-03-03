import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/core/models/misc/reaction_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

import '../base_model.dart';
import 'group_model.dart';

class CommentModel extends BaseModel {
  PersonModel commenter;
  String text;
  DateTime timestamp;
  List<MediaModel>? media;
  GroupModel? group;
  ReactionModel? reaction;

  CommentModel(int id, ProfileModel profile, String raw, this.commenter, this.text, this.timestamp, this.media, this.group, this.reaction) : super(id, profile, raw);

  static const _instagramKey = "string_list_data";

  CommentModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
    : commenter = PersonModel(profile: profile, name: "name", raw: ""),
      timestamp = json.containsKey(_instagramKey) 
        ? ModelHelper.intToTimestamp(((json[_instagramKey]).first)["timestamp"]) ?? DateTime.fromMicrosecondsSinceEpoch(0)
        : DateTime.fromMillisecondsSinceEpoch(0),
      text = json.containsKey(_instagramKey)
        ? ((json[_instagramKey]).first)["value"]
        : "",
    super(0, profile, json.toString());

    CommentModel.fromFacebook(Map<String, dynamic> json, ProfileModel profile)
      : commenter = PersonModel(profile: profile, name: "name", raw: "raw"),
        text = (((json["data"]).first)["comment"])["comment"],
        timestamp = ModelHelper.intToTimestamp(json["timestamp"]),
        group
}