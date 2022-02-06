import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/appsettings_model.dart';

// @UseRowClass(AppSettingsModel)
// class AppSettingsEntity extends Table {
//   @override
//   String get tableName => 'appSettings';

//   IntColumn get key => integer().customConstraint('NOT NULL CHECK (key = 1)')();
//   BoolColumn get darkmode => boolean().named('darkmode')();

//   @override
//   Set<Column> get primaryKey => {key};
// }

@Entity()
class AppSettingsBox {
  int id = 0;
  final bool darkmode;

  AppSettingsBox(this.id, this.darkmode);

  AppSettingsModel toModel() {
    return AppSettingsModel(id, darkmode);
  }
}
