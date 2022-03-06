import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';
import 'package:waultar/data/entities/misc/reaction_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class CommentObjectBox {
  // late PersonModel commented;
  // late String text;
  // DateTime timestamp;
  // List<MediaModel>? media;
  // GroupModel? group;
  // ReactionModel? reaction;

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
  final reaction = ToOne<ReactionObjectBox>();
  final profile = ToOne<ProfileObjectBox>();

  CommentObjectBox({
    this.id = 0,
    required this.text,
    required this.timestamp,
  });
}
