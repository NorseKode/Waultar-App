import 'package:waultar/core/models/content/event_model.dart';
import 'package:waultar/core/models/content/post_model.dart';

class PostEventModel {
  int id;
  PostModel post;
  EventModel event;

  PostEventModel({
    this.id = 0,
    required this.post,
    required this.event,
  });
}
