import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/db/drift_config.dart';

void main() {
  late WaultarDb db;

  setUp(() {
    db = WaultarDb.testing(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Test that DAOs can be invoked', () {
    
    test('given no entries return null', () async {
      final dao = db.todosDao;
      const todo = TodosCompanion(
        title: Value('Setup drift'),
        content: Value('Very urgent'),
      );

      final id = await dao.addTodo(todo);

      expect(id, 0);

    });

  });

}