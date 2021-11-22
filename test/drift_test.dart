import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/db/drift_config.dart';

import 'package:waultar/services/startup.dart';


Future<void> main() async {
  late WaultarDb db;
  await setupServices(testing: true);

  setUp(() {
    db = locator<WaultarDb>();
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
      expect(id, 1);

      final created = await dao.getTodoByIdAsFuture(1);
      expect(created.title, 'Setup drift');

    });

  });

}