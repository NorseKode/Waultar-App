import 'package:waultar/core/models/content/post_lifeevent_model.dart';
import 'package:waultar/data/entities/content/post_life_event_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/builders/placemodel_builder.dart';

import 'postmodel_builders.dart';

PostLifeEventModel makePostLifeEventModel(PostLifeEventObjectBox entity) {
  return PostLifeEventModel(
    id: entity.id,
    post: makePostModel(entity.post.target!),
    title: entity.title,
    place: entity.place.target != null ? makePlaceModel(entity.place.target!) : null,
    raw: entity.raw,
  );
}
