import 'package:waultar/core/models/media_model.dart';

class ImageModel extends MediaModel {
  final String title;
  final String description;

  ImageModel(String uri, String metadata, DateTime timestamp, this.title, this.description) : super(uri, metadata, timestamp);

  ImageModel.fromJson(Map<String, dynamic> json)
      : title = json.containsKey("title") ? json["title"] : "",
        description = json.containsKey("description") ? json["description"] : "",
        super(
          json.containsKey("uri") ? json["uri"] : "",
          json.containsKey("metadata") ? json["metadata"] : "",
          json.containsKey("creation_timestamp") ? DateTime.fromMillisecondsSinceEpoch(json["creation_timestamp"]) : DateTime.now(),
        );
}
