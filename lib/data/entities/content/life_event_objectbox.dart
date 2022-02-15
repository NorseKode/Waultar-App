import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/misc/place_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class LifeEventObjectBox {

  int id;
  String raw;
  final profile = ToOne<ProfileObjectBox>();

  String title;
  final place = ToOne<PlaceObjectBox>();

  LifeEventObjectBox({
    this.id = 0, 
    required this. raw,
    required this.title,
  });
}