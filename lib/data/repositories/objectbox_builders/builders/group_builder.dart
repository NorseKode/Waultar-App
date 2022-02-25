import 'package:waultar/core/models/content/group_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

GroupObjectBox makeGroupEntity(GroupModel model, ObjectBox context) {
  var entity = context.store
      .box<GroupObjectBox>()
      .query(GroupObjectBox_.name.equals(model.name))
      .build()
      .findFirst();
  if (entity == null) {
    entity = GroupObjectBox(raw: model.raw, name: model.name);

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException(
          "Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity =
          context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    entity.isUsers = model.isUsers;

    if (model.timestamp != null) {
      entity.timestamp = model.timestamp;
    }

    if (model.badge != null) {
      entity.badge = model.badge;
    }

    return entity;

  } else {
    return entity;
  }
}
