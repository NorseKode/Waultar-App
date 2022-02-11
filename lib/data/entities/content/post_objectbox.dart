import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';
import 'package:waultar/data/entities/content/life_event_objectbox.dart';
import 'package:waultar/data/entities/content/poll_objectbox.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';
import 'package:waultar/data/entities/misc/tag_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

@Entity()
class PostObjectBox {
  
  int id;
  String raw;
  final profile = ToOne<ProfileObjectBox>();

  @Property(type: PropertyType.date)
  DateTime timestamp;

  // facebook and instagram
  final images = ToMany<ImageObjectBox>();
  final videos = ToMany<VideoObjectBox>();
  final files = ToMany<FileObjectBox>();
  final links = ToMany<LinkObjectBox>();
  String? description;
  String? title;

  final mentions = ToMany<PersonObjectBox>();
  final tags = ToMany<TagObjectBox>();

  // only for facebook
  final event = ToOne<EventObjectBox>();
  final group = ToOne<GroupObjectBox>();
  final poll = ToOne<PollObjectBox>();
  final lifeEvent = ToOne<LifeEventObjectBox>();

  // only for instagram
  bool? isArchived;

  // meta should be misc/other
  String? meta;

  PostObjectBox({
    this.id = 0,
    required this.raw,
    required this.timestamp,
    this.description,
    this.title,
    this.isArchived = false,
    this.meta,
  });
}