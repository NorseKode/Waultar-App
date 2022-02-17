import 'package:waultar/core/models/content/poll_model.dart';
import 'package:waultar/core/models/content/post_model.dart';

class PostPollModel {
  int id;
  PostModel post;
  PollModel poll;

  PostPollModel({
    this.id = 0,
    required this.post,
    required this.poll,
  });
}
