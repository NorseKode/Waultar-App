import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

import 'media_model.dart';

@Entity()
class FacebookPostModel extends BaseModel {
  // @Id()
  int id = 0;
  // final content = ToMany<MediaModel>();
  // final content = ToMany<MediaModel>();
  final String? description;
  final String? title;
  // final EventModel? event;
  // final GroupModel? group;
  // final PollModel? poll;
  // final LifeEventTypeModel lifeEventType;
  final DateTime timestamp;

  FacebookPostModel(
      // this.content,
      this.description,
      this.title,
      //this.event, this.group, this.poll, this.lifeEventType
      this.timestamp);

  FacebookPostModel.fromFacebookPost(FacebookPost facebookPost)
      :
        // content = facebookPost.content,
        description = facebookPost.description,
        title = facebookPost.title,
        // event = facebookPost.event,
        // group = facebookPost.group,
        // poll = facebookPost.poll,
        // lifeEventType = facebookPost.lifeEventType
        timestamp = facebookPost.timestamp;
}

class FacebookPost extends BaseModel {
  final int? id;
  final List<MediaModel>? content;
  final String? description;
  final String? title;
  // final EventModel? event;
  // final GroupModel? group;
  // final PollModel? poll;
  // final LifeEventTypeModel lifeEventType;
  final DateTime timestamp;

  FacebookPost(
      this.id,
      this.content,
      this.description,
      this.title,
      // this.event, this.group, this.poll, this.lifeEventType
      this.timestamp);

  FacebookPost.fromJson(Map<String, dynamic> json)
      : id = null,
        content = null,
        description = json["post"],
        title = json["title"],
        // event = null,
        // group = null,
        // poll = null,
        // lifeEventType = null
        timestamp = DateTime.fromMillisecondsSinceEpoch(json["timestamp"]);

  @override
  String toString() {
    return "Title: $title, description: $description, timestamp: ${timestamp.toString()}";
  }
}
