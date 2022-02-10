import 'package:waultar/core/models/media_model.dart';

import 'model_helper.dart';

class VideoModel extends MediaModel {
  final String title;
  final String description;
  final Uri thumbnail;

  VideoModel(
      Uri uri, String metadata, DateTime timestamp, this.title, this.description, this.thumbnail)
      : super(uri, metadata, timestamp);

  VideoModel.fromJson(Map<String, dynamic> json)
      : title = json.containsKey("title") ? json["title"] : "",
        description = json.containsKey("description") ? json["description"] : "",
        thumbnail = json.containsKey("thumbnail") ? Uri(path: (json["thumbnail"])["uri"]) : Uri(),
        super(
          json.containsKey("uri") ? Uri(path: json["uri"]) : Uri(),
          json.containsKey("metadata") ? json["metadata"] : "",
          ModelHelper.getTimestamp(json),
        );
}
