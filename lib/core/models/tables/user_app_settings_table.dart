import 'package:drift/drift.dart';

@DataClassName('UserSettings')
class UserAppSettings extends Table {
  IntColumn get key => integer().customConstraint('NOT NULL CHECK (key = 1)')();
  BoolColumn get darkmode => boolean().named('darkmode')();

  @override
  Set<Column> get primaryKey => {key};
}
