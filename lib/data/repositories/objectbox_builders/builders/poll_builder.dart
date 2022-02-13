import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/poll_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

PollObjectBox makePoll(PollModel model, ObjectBox context) {
  var entity = context.store
      .box<PollObjectBox>()
      .query(PollObjectBox_.raw.equals(model.raw))
      .build()
      .findFirst();
  if (entity == null) {
    entity = PollObjectBox(raw: model.raw);

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException(
          "Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity =
          context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    if (model.timestamp != null) {
      entity.timestamp = model.timestamp;
    }

    if (model.options != null) {
      entity.options = model.options;
    }

    if (model.question != null) {
      entity.question = model.question;
    }

    entity.isUsers = model.isUsers;

    return entity;
  } else {
    return entity;
  }
}
