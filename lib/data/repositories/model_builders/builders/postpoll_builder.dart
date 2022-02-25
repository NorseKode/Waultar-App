import 'package:waultar/core/models/content/post_poll_model.dart';
import 'package:waultar/data/entities/content/post_poll_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/builders/postmodel_builders.dart';

PostPollModel makePostPollModel(PostPollObjectBox entity) {
  return PostPollModel(
    id: entity.id,
    post: makePostModel(entity.post.target!),
    isUsers: entity.isUsers,
    options: entity.options,
    timestamp: entity.timestamp,
  );
}
