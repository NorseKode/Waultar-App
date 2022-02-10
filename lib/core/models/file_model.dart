import 'media_model.dart';
import 'model_helper.dart';

class FileModel extends MediaModel {
  final Uri thumbnail;

  FileModel(
      Uri uri, String metadata, DateTime timestamp, this.thumbnail)
      : super(uri, metadata, timestamp);

  FileModel.fromJson(Map<String, dynamic> json)
      : thumbnail = Uri(path: "TODO, give standard thumbnail from extension"),
        super(
          json.containsKey("uri") ? Uri(path: json["uri"]) : Uri(),
          json.containsKey("metadata") ? json["metadata"] : "",
          ModelHelper.getTimestamp(json),
        );
}
