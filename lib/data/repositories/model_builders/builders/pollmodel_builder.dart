import 'package:waultar/core/models/content/poll_model.dart';
import 'package:waultar/data/entities/content/poll_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/builders/profilemodel_builder.dart';

PollModel makePollModel(PollObjectBox entity) {
  var id = entity.id;
  var profileEntity = entity.profile.target!;
  var profile = makeProfileModel(profileEntity);
  var isUsers = entity.isUsers;
  var raw = entity.raw;

  var model = PollModel(id: id, profile: profile, raw: raw, isUsers: isUsers);

  if (entity.question != null) model.question = entity.question;
  if (entity.options != null) model.options = entity.options;
  if (entity.timestamp != null) model.timestamp = entity.timestamp;

  return model;
}
