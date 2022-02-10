import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/models/model_helper.dart';

class LinkModel extends MediaModel {
  String? source;

  LinkModel({
    int id = 0,
    required ServiceModel service,
    required String raw,
    required Uri uri,
    String? metadata,
    DateTime? timestamp,
    this.source,
  }) : super(id, service, raw, uri, metadata, timestamp);

  LinkModel.fromJson(Map<String, dynamic> json, ServiceModel service)
      : super(
          0,
          service,
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
}
