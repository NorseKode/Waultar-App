import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/misc/coordinate_model.dart';
import 'package:waultar/data/entities/misc/coordinate_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class PlaceObjectBox {
  int id;
  final profile = ToOne<ProfileObjectBox>();
  String raw;
  String? name;
  String? address;
  final coordinate = ToOne<CoordinateObjectBox>();

  PlaceObjectBox({
    this.id = 0, 
    required this.raw,
    this.name,
    this.address,
  });
  
}