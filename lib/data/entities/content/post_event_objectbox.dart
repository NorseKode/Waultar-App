import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';

@Entity()
class PostEventObjectBox {
  int id;
  final post = ToOne<PostObjectBox>();
  final event = ToOne<EventObjectBox>();

  PostEventObjectBox({
    this.id = 0,
  });
}
