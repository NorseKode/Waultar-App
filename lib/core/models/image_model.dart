import 'package:waultar/core/parsers/parse_helper.dart';

class ImageModel {
  final int? id;
  final String path;
  final String raw;
  final DateTime timestamp;

  ImageModel(this.id, this.path, this.raw, this.timestamp);

  ImageModel.fromJson(Map<String, dynamic> json)
      : id = null,
        path = trySeveralNames(json, ['uri']),
        raw = json.toString(),
        timestamp = getDateTime(json);

  @override
  String toString() {
    return "id: $id, path: $path, timestamp: $timestamp";
  }

}

DateTime getDateTime(var json) {
  var res = trySeveralNames(json, ['timestamp', 'creation_timestamp']);
  // if (res) {
  //   return DateTime.fromMicrosecondsSinceEpoch(int.parse(res));
  // } else {
  return DateTime.now();
  // }
}

class Model {
  final String service;

  Model(this.service);
}
