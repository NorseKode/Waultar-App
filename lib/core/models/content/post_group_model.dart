import 'package:waultar/core/models/content/group_model.dart';
import 'package:waultar/core/models/content/post_model.dart';

class PostGroupModel {
  int id;
  PostModel post;
  GroupModel group;

  PostGroupModel({
    this.id = 0,
    required this.post,
    required this.group,
  });
}
