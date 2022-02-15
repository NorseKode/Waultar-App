import 'package:waultar/core/models/misc/place_model.dart';
import 'package:waultar/data/entities/misc/place_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/builders/coordinatemodel_builder.dart';

import 'profilemodel_builder.dart';

PlaceModel makePlaceModel(PlaceObjectBox placeObjectBox) {
  return PlaceModel(
    id: placeObjectBox.id,
    profile: makeProfileModel(placeObjectBox.profile.target!),
    raw: placeObjectBox.raw,
    name: placeObjectBox.name,
    address: placeObjectBox.address,
    coordinate: placeObjectBox.coordinate.target != null
        ? makeCoordinateModel(placeObjectBox.coordinate.target!)
        : null,
    uri: placeObjectBox.uri != null ? Uri(path: placeObjectBox.uri) : null,
  );
}
