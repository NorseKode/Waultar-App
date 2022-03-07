import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class CommentObjectBox {
  int id;
  final commented = ToOne<PersonObjectBox>();
  String text;
  @Property(type: PropertyType.date)
  DateTime timestamp;
  final images = ToMany<ImageObjectBox>();
  final videos = ToMany<VideoObjectBox>();
  final files = ToMany<FileObjectBox>();
  final links = ToMany<LinkObjectBox>();
  final group = ToOne<GroupObjectBox>();
  // final reaction = ToOne<ReactionObjectBox>();
  final event = ToOne<EventObjectBox>();
  final profile = ToOne<ProfileObjectBox>();
  late String textSearch;

  CommentObjectBox({
    this.id = 0,
    required this.text,
    required this.timestamp,
  });
}
