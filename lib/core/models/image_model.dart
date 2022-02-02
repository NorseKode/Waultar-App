import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

class ImageModel extends BaseModel {
  final int? id;
  final String path;
  final String raw;
  final DateTime timestamp;

  ImageModel(this.id, this.path, this.raw, this.timestamp);

   ImageModel._fromJson(Map<String, dynamic> json)
      : id = null,
        path = ParseHelper.trySeveralNames(json, ['uri']),
        raw = json.toString(),
        timestamp = getDateTime(json);

  static ImageModel fromJson(var json) {
    return ImageModel._fromJson(json);
  }

  @override
  String toString() {
    return "id: $id, path: $path, timestamp: $timestamp";
  }

}

DateTime getDateTime(var json) {
  // var res = ParseHelper.trySeveralNames(json, ['timestamp', 'creation_timestamp']);
  return DateTime.now();
}

