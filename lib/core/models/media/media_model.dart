import 'package:path_provider/path_provider.dart';
import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

abstract class MediaModel extends BaseModel {
  late Uri uri;
  String? metadata;
  DateTime? timestamp;

  MediaModel(int id, ProfileModel profile, String raw, this.uri, this.metadata,
      this.timestamp)
      : super(id, profile, raw);

  // {
  //   this.uri = Uri(
  //       path: dart_path.join(
  //           locator.get<String>(instanceName: "docDir"), uri.path));
  // }

  @override
  String toString() {
    return "id: $id, uri: ${uri.path}, timestamp: $timestamp, metadata: $metadata";
  }
}
