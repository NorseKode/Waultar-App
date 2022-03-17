import 'dart:ui';

import 'package:tuple/tuple.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/startup.dart';

class ImageModel extends MediaModel implements UIModel {
  String? title;
  String? description;

  ImageModel({
    int id = 0,
    required ProfileModel profile,
    required String raw,
    required Uri uri,
    String? metadata,
    DateTime? timestamp,
    this.title,
    this.description,
    List<Tuple2<String, double>>? mediaTags,
  }) : super(id, profile, raw, uri, metadata, timestamp);

  ImageModel.fromJson(Map<String, dynamic> json, ProfileModel profile, {List<String>? mediaTags})
      : title = json.containsKey("title") ? json["title"] : "",
        description = json.containsKey("description") ? json["description"] : "",
        super(
          0,
          profile,
          "", // TODO : parse raw
          json.containsKey("uri") ? Uri(path: json["uri"]) : Uri(),
          json.containsKey("metadata") ? json["metadata"] : "",
          ModelHelper.getTimestamp(json),
        );

  @override
  Color getAssociatedColor() {
    // TODO: implement getAssociatedColor
    throw UnimplementedError();
  }

  @override
  String getMostInformativeField() {
    return uri.path;
  }

  @override
  DateTime getTimestamp() {
    // TODO: implement getTimestamp
    throw UnimplementedError();
  }
}
