import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/content/poll_objectbox.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';

@Entity()
class PostPollObjectBox {
  int id;
  final post = ToOne<PostObjectBox>();
  final poll = ToOne<PollObjectBox>();

  PostPollObjectBox({
    this.id = 0,
  });
}
