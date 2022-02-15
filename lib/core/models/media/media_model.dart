import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

abstract class MediaModel extends BaseModel {
  final Uri uri;
  String? metadata;
  DateTime? timestamp;

  MediaModel(int id, ProfileModel profile, String raw, this.uri, this.metadata,
      this.timestamp)
      : super(id, profile, raw);
}
