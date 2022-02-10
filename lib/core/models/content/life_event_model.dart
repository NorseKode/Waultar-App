import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/misc/place_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class LifeEventModel extends BaseModel {
  
  String title;
  PlaceModel? place;

  LifeEventModel({
    int id = 0, 
    required ProfileModel profile, 
    required String raw,
    required this.title,
    this.place
  }) : super(id, profile, raw);
}