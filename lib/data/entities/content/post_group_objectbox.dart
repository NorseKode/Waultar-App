import 'package:objectbox/objectbox.dart';
import 'group_objectbox.dart';
import 'post_objectbox.dart';

@Entity()
class PostGroupObjectBox {

  int id;
  final post = ToOne<PostObjectBox>();
  final group = ToOne<GroupObjectBox>();
  
  PostGroupObjectBox({
    this.id = 0, 
  });
}