import 'media_model.dart';
import 'model_helper.dart';

class LinkModel extends MediaModel {
  LinkModel(Uri uri, String metadata, DateTime timestamp) : super(uri, metadata, timestamp);

  LinkModel.fromJson(Map<String, dynamic> json)
      : super(
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