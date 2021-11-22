import 'package:drift/drift.dart';
import 'package:waultar/db/drift_config.dart';
import 'package:waultar/models/tables/index.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<WaultarDb> with _$TodosDaoMixin {

  TodosDao(WaultarDb attachedDatabase) : super(attachedDatabase);

    Stream<List<Todo>> todosInCategory(Categorie category) {
    if (category == null) {
      // ignore: deprecated_member_use
      return (select(todos)..where((t) => isNull(t.category))).watch();
    } else {
      return (select(todos)..where((t) => t.category.equals(category.id)))
          .watch();
    }
  }
}