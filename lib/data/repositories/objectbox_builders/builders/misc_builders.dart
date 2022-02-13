import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';
import 'package:waultar/data/entities/misc/tag_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

PersonObjectBox makePerson(PersonModel model, ObjectBox context) {
  QueryBuilder<PersonObjectBox> builder = context.store
      .box<PersonObjectBox>()
      .query(PersonObjectBox_.name.equals(model.name));
  builder.link(
      PersonObjectBox_.profile, ProfileObjectBox_.id.equals(model.profile.id));
  Query<PersonObjectBox> query = builder.build();
  var entity = query.findFirst();

  if (entity == null) {
    entity = PersonObjectBox(raw: model.raw, name: model.name);

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException(
          "Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity =
          context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    if (model.uri != null) {
      entity.uri = model.uri!.path;
    }

    return entity;
  } else {
    return entity;
  }
}

TagObjectBox makeTag(TagModel model, ObjectBox context) {
  var entity = context.store
      .box<TagObjectBox>()
      .query(TagObjectBox_.name.equals(model.name))
      .build()
      .findUnique();
  if (entity == null) {
    return TagObjectBox(name: model.name);
  } else {
    return entity;
  }
}
