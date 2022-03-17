import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

ImageObjectBox makeImageEntity(ImageModel model, ObjectBox context) {
  var entity = context.store
      .box<ImageObjectBox>()
      .query(ImageObjectBox_.uri.equals(model.uri.path))
      .build()
      .findFirst();

  if (entity == null) {
    entity = ImageObjectBox(
      uri: model.uri.path,
      raw: model.raw,
    );
    entity.textSearch = model.uri.path + " ";

    if (model.mediaTags != null && model.mediaTags!.isNotEmpty) {
      entity.mediaTags = model.mediaTags!.map((e) {
        entity!.textSearch += " " + e.item1;

        return "(${e.item1},${e.item2})";
      }).toList();
    }

    entity.title = model.title;
    entity.description = model.description;
    entity.textSearch += model.title ?? " ";
    entity.textSearch += " ";
    entity.textSearch += model.description ?? " ";

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException("Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity = context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    if (model.metadata != null) {
      entity.metadata = model.metadata;
      entity.textSearch += " " + model.metadata!;
    }
    if (model.timestamp != null) {
      entity.timestamp = model.timestamp;
      entity.textSearch += " " + model.timestamp!.toString();
    }

    return entity;
  } else {
    return entity;
  }
}

VideoObjectBox makeVideoEntity(VideoModel model, ObjectBox context) {
  var entity = context.store
      .box<VideoObjectBox>()
      .query(VideoObjectBox_.uri.equals(model.uri.path))
      .build()
      .findFirst();
  if (entity == null) {
    entity = VideoObjectBox(uri: model.uri.path, raw: model.raw);
    entity.textSearch = model.uri.path + " ";

    entity.title = model.title;
    entity.description = model.description;
    entity.textSearch += model.title ?? " ";
    entity.textSearch += " ";
    entity.textSearch += model.description ?? " ";

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException("Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity = context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    if (model.metadata != null) {
      entity.metadata = model.metadata;
      entity.textSearch += " " + model.metadata!;
    }
    if (model.timestamp != null) {
      entity.timestamp = model.timestamp;
      entity.textSearch += " " + model.timestamp!.toString();
    }
    if (model.thumbnail != null) {
      entity.thumbnail = model.thumbnail!.path;
    }

    return entity;
  } else {
    return entity;
  }
}

LinkObjectBox makeLinkEntity(LinkModel model, ObjectBox context) {
  var entity = context.store
      .box<LinkObjectBox>()
      .query(LinkObjectBox_.uri.equals(model.uri.path))
      .build()
      .findFirst();
  if (entity == null) {
    entity = LinkObjectBox(uri: model.uri.path, raw: model.raw);
    entity.textSearch = model.uri.path + " ";

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException("Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity = context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    if (model.metadata != null) {
      entity.metadata = model.metadata;
      entity.textSearch += " " + model.metadata!;
    }
    if (model.timestamp != null) {
      entity.timestamp = model.timestamp;
      entity.textSearch += " " + model.timestamp!.toString();
    }
    if (model.source != null) {
      entity.source = model.source;
      entity.textSearch += " " + model.source!;
    }

    return entity;
  } else {
    return entity;
  }
}

FileObjectBox makeFileEntity(FileModel model, ObjectBox context) {
  var entity = context.store
      .box<FileObjectBox>()
      .query(FileObjectBox_.uri.equals(model.uri.path))
      .build()
      .findFirst();
  if (entity == null) {
    entity = FileObjectBox(uri: model.uri.path, raw: model.raw);
    entity.textSearch = model.uri.path + " ";

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException("Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity = context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    if (model.metadata != null) {
      entity.metadata = model.metadata;
      entity.textSearch += " " + model.metadata!;
    }
    if (model.timestamp != null) {
      entity.timestamp = model.timestamp;
      entity.textSearch += " " + model.timestamp!.toString();
    }
    if (model.thumbnail != null) {
      entity.thumbnail = model.thumbnail!.path;
    }

    return entity;
  } else {
    return entity;
  }
}
