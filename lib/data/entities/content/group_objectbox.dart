import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class GroupObjectBox {

  int id;
  final profile = ToOne<ProfileObjectBox>();
  String raw;
  String name;
  bool isUsers;
  String? badge;

  @Property(type: PropertyType.date)
  DateTime? timestamp;

  GroupObjectBox({
    this.id = 0, 
    required this.raw,
    required this.name,
    this.isUsers = false,
    this.badge,
    this.timestamp,
  });
  
}