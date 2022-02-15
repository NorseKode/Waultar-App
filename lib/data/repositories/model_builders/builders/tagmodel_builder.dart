import 'package:waultar/core/models/misc/tag_model.dart';
import 'package:waultar/data/entities/misc/tag_objectbox.dart';

TagModel makeTagModel(TagObjectBox tagObjectBox) {
  return TagModel(tagObjectBox.id, tagObjectBox.name);
}
