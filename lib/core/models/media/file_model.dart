import 'dart:ui';

import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class FileModel extends MediaModel {
  Uri? thumbnail;

  FileModel({
    int id = 0,
    required ProfileModel profile,
    required String raw,
    required Uri uri,
    String? metadata,
    DateTime? timestamp,
    this.thumbnail,
  }) : super(id, profile, raw, uri, metadata, timestamp);

  FileModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : thumbnail = Uri(path: "TODO, give standard thumbnail from extension"),
        super(
          0,
          profile,
          "",
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
    // TODO: implement getMostInformativeField
    throw UnimplementedError();
  }

  @override
  DateTime getTimestamp() {
    // TODO: implement getTimestamp
    throw UnimplementedError();
  }
}
