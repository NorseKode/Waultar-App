import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/builders/changemodel_builder.dart';

import 'emailmodel_builder.dart';
import 'servicemodel_builder.dart';

ProfileModel makeProfileModel(ProfileObjectBox entity) {
  var serviceEntity = entity.service.target!;
  var serviceModel = makeServiceModel(serviceEntity);

  var emails = <EmailModel>[];
  for (var email in entity.emails) {
    emails.add(makeEmailModel(email));
  }

  var modelToReturn = ProfileModel(
      id: entity.id,
      service: serviceModel,
      uri: Uri(path: entity.uri),
      username: entity.username,
      fullName: entity.fullName,
      emails: emails,
      gender: entity.gender,
      bio: entity.bio,
      currentCity: entity.currentCity,
      phoneNumbers: entity.phoneNumbers,
      isPhoneConfirmed: entity.isPhoneConfirmed,
      createdTimestamp: entity.createdTimestamp,
      isPrivate: entity.isPrivate,
      websites: entity.websites,
      dateOfBirth: entity.dateOfBirth,
      bloodInfo: entity.bloodInfo,
      friendPeerGroup: entity.friendPeerGroup,
      eligibility: entity.eligibility,
      metadata: entity.metadata,
      activities: [], // TODO : activities not modelled in db yet
      raw: entity.raw);

  if (entity.changes.isNotEmpty) {
    var changes = <ChangeModel>[];
    for (var change in entity.changes) {
      changes.add(makeChangeModel(change));
    }
    modelToReturn.changes = changes;
  }

  return modelToReturn;
}
