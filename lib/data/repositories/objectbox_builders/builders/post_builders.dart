import 'package:waultar/core/models/content/post_event_model.dart';
import 'package:waultar/core/models/content/post_lifeevent_model.dart';
import 'package:waultar/core/models/content/post_poll_model.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/content/poll_objectbox.dart';
import 'package:waultar/data/entities/content/post_event_objectbox.dart';
import 'package:waultar/data/entities/content/post_life_event_objectbox.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/entities/content/post_poll_objectbox.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';
import 'package:waultar/data/entities/misc/tag_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

import 'media_builders.dart';
import 'misc_builders.dart';

PostObjectBox makePostEntity(PostModel model, ObjectBox context) {
  var entity = PostObjectBox(raw: model.raw, timestamp: model.timestamp);

  if (model.title != null) {
    entity.title = model.title;
  }
  if (model.description != null) {
    entity.description = model.description;
  }
  if (model.isArchived != null) {
    entity.isArchived = model.isArchived;
  }
  if (model.metadata != null) {
    entity.metadata = model.metadata;
  }

  // the profile HAS to be created in db before storing additional data
  if (model.profile.id == 0) {
    throw ObjectBoxException(
        "Profile Id is 0 - profile must be stored before calling me");
  } else {
    var profileEntity =
        context.store.box<ProfileObjectBox>().get(model.profile.id);
    entity.profile.target = profileEntity;
  }

  // initiate targets for media
  var mediaList = model.medias;
  if (mediaList != null) {
    var imagesToAdd = <ImageObjectBox>[];
    var videosToAdd = <VideoObjectBox>[];
    var linksToAdd = <LinkObjectBox>[];
    var filesToAdd = <FileObjectBox>[];

    for (var media in mediaList) {
      switch (media.runtimeType) {
        case ImageModel:
          var entity = makeImageEntity(media as ImageModel, context);
          imagesToAdd.add(entity);
          break;

        case VideoModel:
          var entity = makeVideoEntity(media as VideoModel, context);
          videosToAdd.add(entity);
          break;

        case LinkModel:
          var entity = makeLinkEntity(media as LinkModel, context);
          linksToAdd.add(entity);
          break;

        case FileModel:
          var entity = makeFileEntity(media as FileModel, context);
          filesToAdd.add(entity);
          break;
      }
    }
    entity.images.addAll(imagesToAdd);
    entity.videos.addAll(videosToAdd);
    entity.files.addAll(filesToAdd);
    entity.links.addAll(linksToAdd);
  }

  var mentions = model.mentions;
  if (mentions != null) {
    var mentionsToAdd = <PersonObjectBox>[];
    for (var person in mentions) {
      var entity = makePersonEntity(person, context);
      mentionsToAdd.add(entity);
    }
    entity.mentions.addAll(mentionsToAdd);
  }

  var tags = model.tags;
  if (tags != null) {
    var tagsToAdd = <TagObjectBox>[];
    for (var tag in tags) {
      var entity = makeTagEntity(tag, context);
      tagsToAdd.add(entity);
    }
    entity.tags.addAll(tagsToAdd);
  }

  return entity;
}

PostPollObjectBox makePostPollEntity(PostPollModel model, ObjectBox context) {
  var entity = PostPollObjectBox(isUsers: model.isUsers);

  var post = context.store.box<PostObjectBox>().get(model.post.id)!;
  
  entity.post.target = post;
  entity.isUsers = model.isUsers;
  entity.options = model.options;
  entity.timestamp = model.timestamp;
  
  return entity;
}

PostEventObjectBox makePostEventEntity(PostEventModel model, ObjectBox context) {
  var entity = PostEventObjectBox();

  var post = context.store.box<PostObjectBox>().get(model.post.id)!;
  var event = context.store.box<EventObjectBox>().get(model.event.id)!;

  entity.post.target = post;
  entity.event.target = event;
  
  return entity;
}

PostLifeEventObjectBox makePostLifeEventEntity(PostLifeEventModel model, ObjectBox context) {
  var entity = PostLifeEventObjectBox(raw: model.raw, title: model.title);

  // the profile HAS to be created in db before storing additional data
  if (model.post.profile.id == 0) {
    throw ObjectBoxException(
        "Profile Id is 0 - profile must be stored before calling me");
  } else {
    var profileEntity =
        context.store.box<ProfileObjectBox>().get(model.post.profile.id);
    entity.profile.target = profileEntity;
  }

  if (model.place != null) {
    var place = makePlaceEntity(model.place!, context);
    entity.place.target = place;
  }

  var post = makePostEntity(model.post, context);
  entity.post.target = post;

  return entity;
}
