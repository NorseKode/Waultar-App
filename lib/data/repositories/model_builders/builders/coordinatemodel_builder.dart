import 'package:waultar/core/models/misc/coordinate_model.dart';
import 'package:waultar/data/entities/misc/coordinate_objectbox.dart';

CoordinateModel makeCoordinateModel(CoordinateObjectBox coordinateObjectBox) {
  return CoordinateModel(
      id: coordinateObjectBox.id,
      longitude: coordinateObjectBox.longitude,
      latitude: coordinateObjectBox.latitude);
}
