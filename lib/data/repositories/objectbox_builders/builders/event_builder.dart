import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

import 'misc_builders.dart';

EventObjectBox makeEvent(EventModel model, ObjectBox context) {
  var entity = context.store
      .box<EventObjectBox>()
      .query(EventObjectBox_.name.equals(model.name))
      .build()
      .findFirst();
  if (entity == null) {
    entity = EventObjectBox(
        raw: model.raw, name: model.name, isUsers: model.isUsers);

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException(
          "Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity =
          context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    if (model.startTimestamp != null) {
      entity.startTimestamp = model.startTimestamp;
    }
    if (model.endTimestamp != null) {
      entity.endTimestamp = model.endTimestamp;
    }
    if (model.createdTimestamp != null) {
      entity.createdTimestamp = model.createdTimestamp;
    }
    if (model.description != null) {
      entity.description = model.description;
    }
    if (model.response != null) {
      entity.dbEventResponse = model.response!.index;
    }
    if (model.place != null) {
      var place = makePlace(model.place!, context);
      entity.place.target = place;
    }

    return entity;
  } else {
    return entity;
  }
}
