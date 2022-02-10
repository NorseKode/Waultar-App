import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/misc/service_model.dart';

abstract class MediaModel extends BaseModel {
  
  Uri uri;
  String? metadata;
  DateTime? timestamp;

  MediaModel(
    int id, 
    ServiceModel service, 
    String raw,
    this.uri,
    this.metadata,
    this.timestamp 
  ) : super(id, service, raw);

}

