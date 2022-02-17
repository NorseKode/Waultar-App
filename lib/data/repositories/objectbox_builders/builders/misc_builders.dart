import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/misc/coordinate_objectbox.dart';
import 'package:waultar/data/entities/misc/email_objectbox.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';
import 'package:waultar/data/entities/misc/place_objectbox.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';
import 'package:waultar/data/entities/misc/tag_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

PersonObjectBox makePersonEntity(PersonModel model, ObjectBox context) {
  QueryBuilder<PersonObjectBox> builder =
      context.store.box<PersonObjectBox>().query(PersonObjectBox_.name.equals(model.name));
  builder.link(PersonObjectBox_.profile, ProfileObjectBox_.id.equals(model.profile.id));
  Query<PersonObjectBox> query = builder.build();
  var entity = query.findFirst();

  if (entity == null) {
    entity = PersonObjectBox(raw: model.raw, name: model.name);

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException("Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity = context.store.box<ProfileObjectBox>().get(model.profile.id);
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

TagObjectBox makeTagEntity(TagModel model, ObjectBox context) {
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

PlaceObjectBox makePlaceEntity(PlaceModel model, ObjectBox context) {
  // it seems like a place (in fb at least) always has a name
  var entity = context.store
      .box<PlaceObjectBox>()
      .query(PlaceObjectBox_.name.equals(model.name))
      .build()
      .findFirst();
  if (entity == null) {
    entity = PlaceObjectBox(raw: model.raw, name: model.name);
    if (model.address != null) {
      entity.address = model.address;
    }
    if (model.coordinate != null) {
      entity.coordinate.target = makeCoordinateEntity(model.coordinate!, context);
    }
    if (model.uri != null) {
      entity.uri = model.uri!.path;
    }
    if (model.profile.id == 0) {
      throw ObjectBoxException("Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity = context.store.box<ProfileObjectBox>().get(model.profile.id);
      entity.profile.target = profileEntity;
    }
    return entity;
  } else {
    return entity;
  }
}

CoordinateObjectBox makeCoordinateEntity(CoordinateModel model, ObjectBox context) {
  var entity = context.store
      .box<CoordinateObjectBox>()
      .query(CoordinateObjectBox_.latitude
          .greaterOrEqual(model.latitude)
          .and(CoordinateObjectBox_.latitude.lessOrEqual(model.latitude))
          .and(CoordinateObjectBox_.longitude.greaterOrEqual(model.longitude))
          .and(CoordinateObjectBox_.latitude.lessOrEqual(model.longitude)))
      .build()
      .findFirst();

  if (entity == null) {
    entity = CoordinateObjectBox(longitude: model.longitude, latitude: model.latitude);
    return entity;
  } else {
    return entity;
  }
}

EmailObjectBox makeEmailEntity(EmailModel model, ObjectBox context) {
  var entity = context.store
      .box<EmailObjectBox>()
      .query(EmailObjectBox_.email.equals(model.email))
      .build()
      .findUnique();

  if (entity == null) {
    entity = EmailObjectBox(raw: model.raw, email: model.email, isCurrent: model.isCurrent);
    return entity;
  } else {
    return entity;
  }
}

ServiceObjectBox makeServiceEntity(ServiceModel model, ObjectBox context) {
  var entity =
      context.store.box<ServiceObjectBox>().query(ServiceObjectBox_.name.equals(model.name)).build().findUnique();

  if (entity == null) {
    return ServiceObjectBox(name: model.name, company: model.company, image: model.image.path);
  } else {
    return entity;
  }

}
