import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/misc/place_model.dart';

class PostLifeEventModel {
  int id;
  PostModel post;
  String title;
  PlaceModel? place;
  String? raw;

  PostLifeEventModel({
    this.id = 0,
    required this.post,
    required this.title,
    this.place,
    this.raw,
  });
}
