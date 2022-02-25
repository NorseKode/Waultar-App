import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/models/misc/appsettings_model.dart';

@Entity()
class AppSettingsObjectBox {
  int id = 0;
  bool darkmode;

  AppSettingsObjectBox(this.id, this.darkmode);

  AppSettingsModel toModel() {
    return AppSettingsModel(id, darkmode);
  }
}
