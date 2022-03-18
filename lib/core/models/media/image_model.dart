import 'dart:ui';

import 'package:path/path.dart' as path_dart;
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/models/ui_model.dart';

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
        description =
            json.containsKey("description") ? json["description"] : "",
        super(
          0,
          profile,
          "", // TODO : parse raw
          json.containsKey("uri") 
            ? Uri(path: path_dart.normalize(path_dart.join(profile.basePathToFiles!, json["uri"].toString()))) 
            : Uri(),
          json.containsKey("metadata") ? json["metadata"] : "",
          ModelHelper.getTimestamp(json),
        );

  @override
  Color getAssociatedColor() {
    return Colors.pink;
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
