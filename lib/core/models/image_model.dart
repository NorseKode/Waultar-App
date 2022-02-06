import 'package:waultar/core/models/media_model.dart';

class ImageModel extends MediaModel {
  final String title;
  final String description;

  ImageModel(uri, metadata, timestamp, this.title, this.description) : super(uri, metadata, timestamp);

  ImageModel.fromJson(Map<String, dynamic> json)
      : title = json.containsKey("title") ? json["title"] : "",
        description = json.containsKey("description") ? json["description"] : "",
        super(
          json.containsKey("uri") ? json["uri"] : "",
          json.containsKey("metadata") ? json["metadata"] : "",
          json.containsKey("creation_timestamp") ? DateTime.fromMillisecondsSinceEpoch(json["creation_timestamp"]) : DateTime.now(),
        );

  // @override
  // ImageModel fromJson(var json) {
  //   return ImageModel._fromJson(json);
  // }

  // @override
  // String toString() {
  //   return "id: $id, path: $path, timestamp: $timestamp";
  // }

}

DateTime getDateTime(var json) {
  // var res = ParseHelper.trySeveralNames(json, ['timestamp', 'creation_timestamp']);
  return DateTime.now();
}
