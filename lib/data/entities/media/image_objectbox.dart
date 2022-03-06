import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class ImageObjectBox {
  int id;
  final profile = ToOne<ProfileObjectBox>();
  String uri;
  String? metadata;
  @Property(type: PropertyType.date)
  DateTime? timestamp;
  String? title;
  String? description;
  String raw;
  late String textSearch;

  ImageObjectBox({
    this.id = 0,
    required this.uri,
    this.metadata,
    this.timestamp,
    this.title,
    this.description,
    required this.raw,
  });
}
