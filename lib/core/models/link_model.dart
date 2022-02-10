import 'package:waultar/core/models/media_model.dart';
import 'package:waultar/core/models/service_model.dart';

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

}
