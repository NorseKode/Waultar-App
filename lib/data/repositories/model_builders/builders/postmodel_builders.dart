import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';

import 'mediamodel_builder.dart';
import 'profilemodel_builder.dart';
import 'personmodel_builder.dart';
import 'tagmodel_builder.dart';

PostModel makePostModel(PostObjectBox entity) {
  var profileEntity = entity.profile.target!;
  var profile = makeProfileModel(profileEntity);

  var modelToReturn = PostModel(
    id: entity.id,
    profile: profile,
    raw: entity.raw,
    timestamp: entity.timestamp,
    mentions:
        entity.mentions.map((element) => makePersonModel(element)).toList(),
    tags: entity.tags.map((element) => makeTagModel(element)).toList(),
    // event: entity.event.target != null
    //     ? makeEventModel(entity.event.target!)
    //     : null,
    // // TODO
    // group: null,
    // poll:
    //     entity.poll.target != null ? makePollModel(entity.poll.target!) : null,
    // // TODO
    // lifeEvent: null,
    description: entity.description,
    title: entity.title,
    isArchived: entity.isArchived,
    metadata: entity.metadata,
  );

  var media = <MediaModel>[];
  if (entity.images.isNotEmpty) {
    for (var image in entity.images) {
      media.add(makeImageModel(image));
    }
  }
  if (entity.videos.isNotEmpty) {
    for (var video in entity.videos) {
      media.add(makeVideoModel(video));
    }
  }
  if (entity.links.isNotEmpty) {
    for (var link in entity.links) {
      media.add(makeLinkModel(link));
    }
  }
  if (entity.files.isNotEmpty) {
    for (var file in entity.files) {
      media.add(makeFileModel(file));
    }
  }

  if (media.isNotEmpty) modelToReturn.medias = media;

  return modelToReturn;
}
