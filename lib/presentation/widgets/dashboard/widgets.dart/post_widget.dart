import 'package:flutter/material.dart';
import 'package:waultar/core/models/content/post_model.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  // DateTime timestamp;
  // String? description;
  // String? title;
  // List<MediaModel>? medias;
  // List<TagModel>? tags;
  // List<PersonModel>? mentions;
  // bool? isArchived;
}
