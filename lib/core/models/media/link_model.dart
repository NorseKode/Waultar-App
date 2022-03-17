import 'dart:ui';

import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class LinkModel extends MediaModel {
  String? source;

  LinkModel({
    int id = 0,
    required ProfileModel profile,
    required String raw,
    required Uri uri,
    String? metadata,
    DateTime? timestamp,
    this.source,
  }) : super(id, profile, raw, uri, metadata, timestamp);

  LinkModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : super(
          0,
          profile,
          "",
          json.containsKey("uri")
              ? Uri(path: json["uri"])
              : json.containsKey("link")
                  ? Uri(path: json["link"])
                  : json.containsKey("content")
                      ? Uri(path: json["content"])
                      : Uri(),
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
    // TODO: implement getMostInformativeField
    throw UnimplementedError();
  }

  @override
  DateTime getTimestamp() {
    // TODO: implement getTimestamp
    throw UnimplementedError();
  }
}
