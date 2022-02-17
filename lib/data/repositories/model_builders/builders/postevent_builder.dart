
import 'package:waultar/core/models/content/post_event_model.dart';
import 'package:waultar/data/entities/content/post_event_objectbox.dart';

import 'eventmodel_builder.dart';
import 'postmodel_builders.dart';

PostEventModel makePostEventModel(PostEventObjectBox entity) {
  return PostEventModel(
    id: entity.id,
    post: makePostModel(entity.post.target!),
    event: makeEventModel(entity.event.target!),
  );
}
