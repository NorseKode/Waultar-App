import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';
import 'package:waultar/data/repositories/objectbox_builders/builders/index.dart';

ProfileObjectBox makeProfileEntity(ProfileModel model, ObjectBox context) {
  var entity = ProfileObjectBox(
    uri: model.uri.path,
    username: model.username,
    fullName: model.fullName,
    gender: model.gender,
    bio: model.bio,
    currentCity: model.currentCity,
    phoneNumbers: model.phoneNumbers,
    isPhoneConfirmed: model.isPhoneConfirmed,
    createdTimestamp: model.createdTimestamp,
    isPrivate: model.isPrivate,
    websites: model.websites,
    dateOfBirth: model.dateOfBirth,
    bloodInfo: model.bloodInfo,
    friendPeerGroup: model.friendPeerGroup,
    eligibility: model.eligibility,
    metadata: model.metadata,
    raw: model.raw,
  );

  if (model.profilePicture != null && model.profilePicture is ImageModel) {
    entity.profilePicture.target = makeImageEntity(model.profilePicture! as ImageModel, context);
  }
  entity.emails.addAll(model.emails.map((e) => makeEmailEntity(e, context)));
  entity.service.target = makeServiceEntity(model.service, context);
  // TODO: changes
  // TODO: activity

  return entity;
}
