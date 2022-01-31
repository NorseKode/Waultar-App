import 'package:drift/drift.dart';
import 'package:waultar/db/configs/drift_config.dart';
import 'package:waultar/parser/base_entity.dart';
import 'package:waultar/parser/parse_helper.dart';

@UseRowClass(Image)
class ImagesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  TextColumn get raw => text()();
  DateTimeColumn get timestamp => dateTime()();
}

class Image implements Insertable<Image> {
  final int? id;
  final String path;
  final String raw;
  final DateTime timestamp;

  Image(this.id, this.path, this.raw, this.timestamp);

  Image.fromJson(Map<String, dynamic> json)
      : id = null,
        path = trySeveralNames(json, ['uri']),
        raw = json.toString(),
        timestamp = getDateTime(json);

  static Image fromJson2(var json) {
    return Image.fromJson(json);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ImagesTableCompanion(
      id: Value(id!),
      path: Value(path),
      raw: Value(raw),
      timestamp: Value(timestamp),
    ).toColumns(nullToAbsent);
  }

  @override
  String toString() {
    return "id: ${id}, path: ${path}, timestamp: ${timestamp}";
  }

}

DateTime getDateTime(var json) {
  var res = trySeveralNames(json, ['timestamp', 'creation_timestamp']);
  return DateTime.now();
}
