import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/models/model_helper.dart';

class VideoModel extends MediaModel {
  String title;
  String description;
  Uri? thumbnail;

  VideoModel({
    int id = 0,
    required ServiceModel service,
    required String raw,
    required Uri uri,
    String? metadata,
    DateTime? timestamp,
    required this.title,
    required this.description,
    this.thumbnail,
  }) : super(id, service, raw, uri, metadata, timestamp);

  VideoModel.fromJson(Map<String, dynamic> json, ServiceModel service)
      : title = json.containsKey("title") ? json["title"] : "",
        description =
            json.containsKey("description") ? json["description"] : "",
        thumbnail = json.containsKey("thumbnail")
            ? Uri(path: (json["thumbnail"])["uri"])
            : Uri(),
        super(
          0,
          service,
          "",
          json.containsKey("uri") ? Uri(path: json["uri"]) : Uri(),
          json.containsKey("metadata") ? json["metadata"] : "",
          ModelHelper.getTimestamp(json),
        );
}
