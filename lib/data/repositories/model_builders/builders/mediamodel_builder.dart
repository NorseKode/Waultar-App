import 'package:waultar/core/models/media/file_model.dart';
import 'package:waultar/core/models/media/image_model.dart';
import 'package:waultar/core/models/media/link_model.dart';
import 'package:waultar/core/models/media/video_model.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/builders/profilemodel_builder.dart';

ImageModel makeImageModel(ImageObjectBox entity) {
  var id = entity.id;
  var profile = makeProfileModel(entity.profile.target!);
  var raw = entity.raw;
  var uri = Uri(path: entity.uri);

  var model = ImageModel(
    id: id,
    profile: profile,
    raw: raw,
    uri: uri,
  );

  if (entity.title != null) model.title = entity.title;
  if (entity.description != null) model.description = entity.description;
  if (entity.metadata != null) model.metadata = entity.metadata;
  if (entity.timestamp != null) model.timestamp = entity.timestamp;

  return model;
}

VideoModel makeVideoModel(VideoObjectBox entity) {
  var id = entity.id;
  var profile = makeProfileModel(entity.profile.target!);
  var raw = entity.raw;
  var uri = Uri(path: entity.uri);

  var model = VideoModel(id: id, profile: profile, raw: raw, uri: uri);

  if (entity.title != null) model.title = entity.title;
  if (entity.description != null) model.description = entity.description;
  if (entity.metadata != null) model.metadata = entity.metadata;
  if (entity.timestamp != null) model.timestamp = entity.timestamp;
  if (entity.thumbnail != null) model.thumbnail = Uri(path: entity.thumbnail);

  return model;
}

LinkModel makeLinkModel(LinkObjectBox entity) {
  var id = entity.id;
  var profile = makeProfileModel(entity.profile.target!);
  var raw = entity.raw;
  var uri = Uri(path: entity.uri);

  var model = LinkModel(id: id, profile: profile, raw: raw, uri: uri);

  if (entity.metadata != null) model.metadata = entity.metadata;
  if (entity.timestamp != null) model.timestamp = entity.timestamp;
  if (entity.source != null) model.source = entity.source;

  return model;
}

FileModel makeFileModel(FileObjectBox entity) {
  var id = entity.id;
  var profile = makeProfileModel(entity.profile.target!);
  var raw = entity.raw;
  var uri = Uri(path: entity.uri);

  var model = FileModel(id: id, profile: profile, raw: raw, uri: uri);

  if (entity.metadata != null) model.metadata = entity.metadata;
  if (entity.timestamp != null) model.timestamp = entity.timestamp;
  if (entity.thumbnail != null) model.thumbnail = Uri(path: entity.thumbnail);

  return model;
}
