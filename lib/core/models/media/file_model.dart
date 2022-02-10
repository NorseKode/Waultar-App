import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/models/model_helper.dart';

class FileModel extends MediaModel {
  Uri? thumbnail;

  FileModel({
    int id = 0,
    required ServiceModel service,
    required String raw,
    required Uri uri,
    String? metadata,
    DateTime? timestamp,
    this.thumbnail,
  }) : super(id, service, raw, uri, metadata, timestamp);

  FileModel.fromJson(Map<String, dynamic> json, ServiceModel service)
      : thumbnail = Uri(path: "TODO, give standard thumbnail from extension"),
        super(
          0,
          service,
          "",
          json.containsKey("uri") ? Uri(path: json["uri"]) : Uri(),
          json.containsKey("metadata") ? json["metadata"] : "",
          ModelHelper.getTimestamp(json),
        );
}
