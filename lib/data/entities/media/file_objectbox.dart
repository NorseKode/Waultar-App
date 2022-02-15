import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class FileObjectBox {
  int id;
  final profile = ToOne<ProfileObjectBox>();
  String raw;

  String uri;
  String? metadata;

  @Property(type: PropertyType.date)
  DateTime? timestamp;

  String? thumbnail;

  FileObjectBox({
    this.id = 0,
    required this.raw,
    required this.uri,
    this.metadata,
    this.timestamp,
    this.thumbnail,
  });
}
