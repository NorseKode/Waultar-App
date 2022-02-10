import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/place_model.dart';
import 'package:waultar/core/models/service_model.dart';

class LifeEventModel extends BaseModel {
  
  String title;
  PlaceModel? place;

  LifeEventModel({
    int id = 0, 
    required ServiceModel service, 
    required String raw,
    required this.title,
    this.place
  }) : super(id, service, raw);
}