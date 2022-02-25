import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/misc/change_objectbox.dart';

ChangeModel makeChangeModel(ChangeObjectBox entity) {
  var modelToReturn = ChangeModel(
      id: entity.id,
      valueName: entity.valueName,
      previousValue: entity.previousValue,
      newValue: entity.newValue,
      timestamp: entity.timestamp,
      raw: entity.raw);
  return modelToReturn;
}
