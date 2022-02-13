import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/misc/coordinate_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class PlaceObjectBox {
  int id;
  final profile = ToOne<ProfileObjectBox>();
  String raw;
  String name;
  String? address;
  final coordinate = ToOne<CoordinateObjectBox>();
  String? uri;

  PlaceObjectBox({
    this.id = 0, 
    required this.raw,
    required this.name,
    this.address,
    this.uri
  });
  
}