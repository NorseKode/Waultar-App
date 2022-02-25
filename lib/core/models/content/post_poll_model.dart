import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/models/content/poll_model.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/startup.dart';

class PostPollModel {
  int id;
  late PostModel post;
  // String? question;
  late bool isUsers;

  // store options in raw json
  List<String>? options;
  DateTime? timestamp;

  PostPollModel({
    this.id = 0,
    required this.post,
    // this.question,
    required this.isUsers,
    this.options,
    this.timestamp,
  });

  PostPollModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : id = 0,
        options = <String>[],
        timestamp = json.containsKey("timestamp")
            ? ModelHelper.intToTimestamp(json["timestamp"])
            : DateTime.fromMicrosecondsSinceEpoch(0) {
    var appLogger = locator.get<AppLogger>(instanceName: 'logger');
    post = PostModel(
        profile: profile, raw: json.toString(), timestamp: timestamp!, title: json["title"]);
    
    var tempAttac = json["attachments"];
    if (tempAttac.length != 1) {
      appLogger.logger.shout("Error in PostPollModel, attachments is not equal to 1");
    }

    var tempData = (tempAttac.first)["data"];
    if (tempData.length != 1) {
      appLogger.logger.shout("Error in PostPollModel, data is not equal to 1");
    }

    var pollData = (tempData.first)["poll"];

    if (pollData.containsKey("question")) {
      post.description = pollData["question"];
    }

    for (var option in pollData["options"]) {
      options!.add(option["option"]);
      options!.add(option["voted"].toString());
    }

    if (post.description != null || options!.contains("false")) {
      isUsers = true;
    } else {
      isUsers = false;
    }
  }
}
