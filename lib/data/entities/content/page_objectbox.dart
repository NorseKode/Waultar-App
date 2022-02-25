import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class PageObjectBox {

  int id;
  String raw;
  final profile = ToOne<ProfileObjectBox>();

  final String name;
  final bool isUsers;

  // only if isUsers == true
  final String? uri;

  PageObjectBox({
    this.id = 0, 
    required this.raw,
    required this.name,
    this.isUsers = false,
    this.uri,
  });
  
}