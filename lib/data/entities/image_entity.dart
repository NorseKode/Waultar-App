import 'package:drift/drift.dart';
import 'package:waultar/core/models/image_model.dart';

@UseRowClass(ImageModel)
class ImageEntity extends Table{

  @override
  String get tableName => 'images';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  TextColumn get raw => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get description => text()();
  TextColumn get uri => text()();
  TextColumn get title => text()();
  TextColumn get metadata => text()();
}