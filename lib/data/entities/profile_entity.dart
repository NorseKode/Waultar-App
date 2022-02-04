import 'package:drift/drift.dart';
import 'package:waultar/core/models/profile_model.dart';

@UseRowClass(ProfileModel)
class ProfileEntity extends Table {

  @override
  String get tableName => 'profiles';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withDefault(const Constant('unknown'))();
  TextColumn get name => text().withDefault(const Constant('unknown'))();
  TextColumn get email => text().withDefault(const Constant('unknown'))();
  TextColumn get gender => text().withDefault(const Constant('unknown'))();
  TextColumn get bio => text().withDefault(const Constant('unknown'))();
  TextColumn get phoneNumber => text().withDefault(const Constant('unknown'))();
  DateTimeColumn get dateOfBirth => dateTime()();
  TextColumn get profileUri => text().withDefault(const Constant('unknown'))();
  TextColumn get raw => text()();
}
