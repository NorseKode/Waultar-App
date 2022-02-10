import 'package:waultar/core/models/media_model.dart';
import 'package:waultar/core/models/model_helper.dart';

class ImageModel extends MediaModel {
  final String title;
  final String description;

  ImageModel(Uri uri, String metadata, DateTime timestamp, this.title, this.description) : super(uri, metadata, timestamp);

  ImageModel.fromJson(Map<String, dynamic> json)
      : title = json.containsKey("title") ? json["title"] : "",
        description = json.containsKey("description") ? json["description"] : "",
        super(
          json.containsKey("uri") ? Uri(path: json["uri"]) : Uri(),
          json.containsKey("metadata") ? json["metadata"] : "",
          ModelHelper.getTimestamp(json),
        );
}
