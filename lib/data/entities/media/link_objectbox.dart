import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class LinkObjectBox {
  int id;
  String uri;
  String? metadata;
  @Property(type: PropertyType.date)
  DateTime? timestamp;
  final profile = ToOne<ProfileObjectBox>();
  String? source;
  String raw;


  LinkObjectBox({
    this.id = 0,
    required this.uri,
    this.metadata,
    this.timestamp,
    this.source,
    required this.raw,
  });
}
