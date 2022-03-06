import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class VideoObjectBox {
  int id;
  final profile = ToOne<ProfileObjectBox>();
  String uri;
  String? metadata;
  @Property(type: PropertyType.date)
  DateTime? timestamp;
  String? title;
  String? description;
  String? thumbnail;
  String raw;
  late String textSearch;

  VideoObjectBox({
    this.id = 0,
    required this.uri,
    this.metadata,
    this.timestamp,
    this.title,
    this.description,
    this.thumbnail,
    required this.raw,
  });
}
