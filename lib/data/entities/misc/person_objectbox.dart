import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class PersonObjectBox {
  int id;
  final profile = ToOne<ProfileObjectBox>();
  String raw;

  String name;
  String? uri;

  PersonObjectBox(
      {this.id = 0, required this.raw, required this.name, this.uri});
}
