import 'package:waultar/core/models/content/group_model.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/builders/profilemodel_builder.dart';

GroupModel makeGroupModel(GroupObjectBox entity) {
  return GroupModel(
    profile: makeProfileModel(entity.profile.target!),
    raw: entity.raw,
    name: entity.name,
    isUsers: entity.isUsers,
    id: entity.id,
    timestamp: entity.timestamp,
    badge: entity.badge,
  );
}
