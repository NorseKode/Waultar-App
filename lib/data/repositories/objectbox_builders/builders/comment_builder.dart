import 'package:flutter/material.dart';
import 'package:waultar/core/models/content/comment_model.dart';
import 'package:waultar/core/models/media/file_model.dart';
import 'package:waultar/core/models/media/image_model.dart';
import 'package:waultar/core/models/media/link_model.dart';
import 'package:waultar/core/models/media/video_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/content/comment_objectbox.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/repositories/objectbox_builders/builders/group_builder.dart';
import 'package:waultar/data/repositories/objectbox_builders/builders/media_builders.dart';

CommentObjectBox makeCommentEntity(CommentModel model, ObjectBox context) {
  var searchBuilder = StringBuffer();
  var entity = CommentObjectBox(text: model.text, timestamp: model.timestamp);
  
  searchBuilder.write(model.timestamp.toString());
  searchBuilder.write(" " + model.text);
  
  if (model.group != null) {
    entity.group.target = makeGroupEntity(model.group!, context);
    searchBuilder.write(" " + model.group!.name);
  }

  var mediaList = model.media;
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

  return entity;
}
