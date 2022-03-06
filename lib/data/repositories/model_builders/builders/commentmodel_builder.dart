import 'package:waultar/core/models/content/comment_model.dart';
import 'package:waultar/data/entities/content/comment_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/builders/groupmodel_builder.dart';
import 'package:waultar/data/repositories/model_builders/builders/personmodel_builder.dart';
import 'package:waultar/data/repositories/model_builders/builders/profilemodel_builder.dart';

CommentModel makeCommentModel(CommentObjectBox entity) {
  return CommentModel(
    profile: makeProfileModel(entity.profile.target!),
    raw: '',
    commented: makePersonModel(entity.commented.target!),
    text: entity.text,
    timestamp: entity.timestamp,
    group: entity.group.target != null
      ? makeGroupModel(entity.group.target!)
      : null,
    
  );
}
