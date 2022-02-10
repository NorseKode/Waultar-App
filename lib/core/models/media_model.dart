import 'package:waultar/core/models/base_model.dart';

abstract class MediaModel extends BaseModel {
  final Uri uri;
  final String metadata;
  final DateTime? timestamp;

  MediaModel(this.uri, this.metadata, this.timestamp);
}