import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';


part 'drift_config.g.dart';


LazyDatabase _openConnection()
{
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [])
class WaultarDb extends _$WaultarDb
{
  WaultarDb() : super(_openConnection());

  // if you change or add table definitions, this number should be incremented. 
  // it will automatically handle migrations
  @override 
  int get schemaVersion => 1;
}
