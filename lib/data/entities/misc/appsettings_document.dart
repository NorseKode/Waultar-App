import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/misc/appsettings_model.dart';

@Entity()
class AppSettingsDocument {
  int id = 0;
  bool darkmode;

  AppSettingsDocument(this.id, this.darkmode);

  AppSettingsModel toModel() {
    return AppSettingsModel(id, darkmode);
  }
}
