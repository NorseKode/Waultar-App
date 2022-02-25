import 'package:waultar/core/models/content/event_model.dart';
import 'package:waultar/core/models/content/post_poll_model.dart';

abstract class IPostPollRepository {
  int addPostPoll(PostPollModel model);
  Future<int> addPostPollAsync(PostPollModel model);
  List<PostPollModel> getAllPostPolls();
  int removeAll();
}
