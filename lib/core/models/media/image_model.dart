import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class ImageModel extends MediaModel {
  
  String title;
  String description;

  ImageModel({
    int id = 0,
    required ProfileModel profile, 
    required String raw,
    required Uri uri,
    String? metadata,
    DateTime? timestamp,
    required this.title,
    required this.description,
  }) : super(id, profile, raw, uri, metadata, timestamp);


  ImageModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
      : title = json.containsKey("title") ? json["title"] : "",
        description = json.containsKey("description") ? json["description"] : "",
        super(
          0, 
          profile,
          "", // TODO : parse raw
          json.containsKey("uri") ? Uri(path: json["uri"]) : Uri(),
          json.containsKey("metadata") ? json["metadata"] : "",
          ModelHelper.getTimestamp(json),
        );


}
