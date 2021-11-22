import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/db/drift_config.dart';

import 'dart:io';
import 'dart:ffi';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3/open.dart';


DynamicLibrary _openOnWindows() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript = File('${scriptDir.path}/sqlite3.dll');
  return DynamicLibrary.open(libraryNextToScript.path);
}

void main() {
  late WaultarDb db;

  setUp(() {
    open.overrideFor(OperatingSystem.windows, _openOnWindows);
    db = WaultarDb.testing(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Test that DAOs can be invoked', () {
    
    test('given new entry returns id and correct entry', () async {

      final dao = db.todosDao;
      const todo = TodosCompanion(
        title: Value('Setup drift'),
        content: Value('Very urgent'),
      );

      final id = await dao.addTodo(todo);
      expect(id, 0);

      final created = await dao.getTodoByIdAsFuture(0);
      expect(created.title, 'Setup drift');

    });

  });

}