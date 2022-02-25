import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class PollModel extends BaseModel {
  String? question;
  bool isUsers;

  // store options in raw json
  String? options;
  DateTime? timestamp;

  PollModel({
    int id = 0,
    required ProfileModel profile,
    required String raw,
    this.question,
    this.isUsers = false,
    this.options,
    this.timestamp,
  }) : super(id, profile, raw);

  PollModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : timestamp = json.containsKey("timestamp") 
        ? ModelHelper.getTimestamp(json["timestamp"]) 
        : DateTime.fromMicrosecondsSinceEpoch(0),
        isUsers = json.containsKey("question") ? true : false,
        options =
            json.containsKey("options") ? json["options"].toString() : null,
        super(0, profile, json.toString());

  @override
  String toString() {
    return "Question: $question, Options: $options, isUsers: $isUsers, Timestamp: $timestamp";
  }
}
