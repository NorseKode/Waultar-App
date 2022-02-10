import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/appsettings_model.dart';

@Entity()
class AppSettingsBox {
  int id = 0;
  bool darkmode;

  AppSettingsBox(this.id, this.darkmode);

  AppSettingsModel toModel() {
    return AppSettingsModel(id, darkmode);
  }
}
