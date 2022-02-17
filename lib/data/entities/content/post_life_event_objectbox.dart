import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/misc/place_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

import 'post_objectbox.dart';

@Entity()
class PostLifeEventObjectBox {

  int id;
  String raw;
  final profile = ToOne<ProfileObjectBox>();

  final post = ToOne<PostObjectBox>();

  String title;
  final place = ToOne<PlaceObjectBox>();

  PostLifeEventObjectBox({
    this.id = 0, 
    required this. raw,
    required this.title,
  });
}