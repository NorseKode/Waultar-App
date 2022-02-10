import 'package:waultar/core/models/media_model.dart';
import 'package:waultar/core/models/service_model.dart';

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


  // ImageModel.fromJson(Map<String, dynamic> json)
  //     : title = json.containsKey("title") ? json["title"] : "",
  //       description = json.containsKey("description") ? json["description"] : "",
  //       super(
  //         json.containsKey("uri") ? json["uri"] : "",
  //         json.containsKey("metadata") ? json["metadata"] : "",
  //         json.containsKey("creation_timestamp") ? DateTime.fromMillisecondsSinceEpoch(json["creation_timestamp"]) : DateTime.now(),
  //       );

  // @override
  // ImageModel fromJson(var json) {
  //   return ImageModel._fromJson(json);
  // }

  // @override
  // String toString() {
  //   return "id: $id, path: $path, timestamp: $timestamp";
  // }

}
