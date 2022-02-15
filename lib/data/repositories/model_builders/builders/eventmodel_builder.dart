import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';

import 'placemodel_builder.dart';
import 'profilemodel_builder.dart';

EventModel makeEventModel(EventObjectBox eventObjectBox) {
  return EventModel(
      profile: makeProfileModel(eventObjectBox.profile.target!),
      raw: eventObjectBox.raw,
      name: eventObjectBox.name,
      isUsers: eventObjectBox.isUsers,
      id: eventObjectBox.id,
      startTimestamp: eventObjectBox.startTimestamp,
      endTimestamp: eventObjectBox.endTimestamp,
      createdTimestamp: eventObjectBox.createdTimestamp,
      description: eventObjectBox.description,
      place: eventObjectBox.place.target != null
          ? makePlaceModel(eventObjectBox.place.target!)
          : null,
      response: eventObjectBox.response);
}
