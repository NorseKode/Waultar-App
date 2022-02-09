import 'package:waultar/core/models/media_model.dart';

class VideoModel extends MediaModel {
  final String title;
  final String description;
  final String thumbnail;

  VideoModel(uri, metadata, timestamp, this.title, this.description, this.thumbnail) : super(uri, metadata, timestamp);

  VideoModel.fromJson(Map<String, dynamic> json)
      : title = json.containsKey("title") ? json["title"] : "",
        description = json.containsKey("description") ? json["description"] : "",
        thumbnail = "",
        super(
          json.containsKey("uri") ? json["uri"] : "",
          json.containsKey("metadata") ? json["metadata"] : "",
          json.containsKey("creation_timestamp") ? DateTime.fromMillisecondsSinceEpoch(json["creation_timestamp"]) : DateTime.now(),
        );
}
