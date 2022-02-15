import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/misc/coordinate_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class PlaceModel extends BaseModel {
  String name;
  String? address;
  CoordinateModel? coordinate;
  Uri? uri;

  PlaceModel({
    int id = 0, 
    required ProfileModel profile,
    required String raw,
    required this.name,
    this.address,
    this.coordinate,
    this.uri
  }) : super(id, profile, raw);
  
}