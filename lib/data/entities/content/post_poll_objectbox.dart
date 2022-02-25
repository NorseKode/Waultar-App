import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';

@Entity()
class PostPollObjectBox {
  int id;
  final post = ToOne<PostObjectBox>();
  bool isUsers;

  // store options in raw json
  List<String>? options;
  @Property(type: PropertyType.date)
  DateTime? timestamp;

  PostPollObjectBox({
    this.id = 0,
    required this.isUsers,
    this.options,
    this.timestamp,
  });
}
