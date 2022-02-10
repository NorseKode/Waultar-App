import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/coordinate_model.dart';
import 'package:waultar/core/models/service_model.dart';

class PlaceModel extends BaseModel {
  String? name;
  String? address;
  CoordinateModel? coordinate;

  PlaceModel({
    int id = 0, 
    required ServiceModel service,
    required String raw,
    this.name,
    this.address,
    this.coordinate,
  }) : super(id, service, raw);
  
}