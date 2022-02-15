import 'package:waultar/core/models/misc/person_model.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';

import 'profilemodel_builder.dart';

PersonModel makePersonModel(PersonObjectBox personObjectBox) {
  return PersonModel(
      id: personObjectBox.id,
      profile: makeProfileModel(personObjectBox.profile.target!),
      name: personObjectBox.name,
      raw: personObjectBox.raw,
      uri: personObjectBox.uri != null ? Uri(path: personObjectBox.uri) : null);
}
