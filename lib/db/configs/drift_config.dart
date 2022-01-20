import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:waultar/db/DAOs/user_settings_dao.dart';
import 'dart:io';
import 'package:waultar/models/tables/index.dart';


part 'drift_config.g.dart';


LazyDatabase _openConnection()
{
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftDatabase(
  tables: [
    // all tables need to be registered here :
    UserAppSettings,
  ],
  daos: [
    // as well as the respective DAOs :
    UserSettingsDao,
  ]
)
class WaultarDb extends _$WaultarDb
{
  WaultarDb() : super(_openConnection());

  // constructor extension for testing
  WaultarDb.testing(QueryExecutor q) : super(q);

  // enabling isolation
  // WaultarDb.connect(DatabaseConnection connection) : super.connect(connection);

  // if you change or add table definitions, this number should be incremented. 
  // it will automatically handle migrations
  @override 
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();

      var defaults = const UserAppSettingsCompanion(
        key: Value(1),
        darkmode: Value(false)
      );

      await into(userAppSettings).insert(defaults);
    }
  );
}
