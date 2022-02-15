import 'package:waultar/startup.dart';

import '../entities/misc/appsettings_objectbox.dart';
import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store) {
    // additional setup code here
    final appSettingsBox = store.box<AppSettingsObjectBox>();
    if (appSettingsBox.count() == 0) {
      var initialAppSettings = AppSettingsObjectBox(0, false);
      appSettingsBox.put(initialAppSettings);
    }
  }

  static Future<ObjectBox> create() async {
    final store = await openStore(directory: locator.get<String>(instanceName: 'db_folder'));
    return ObjectBox._create(store);
  }
}
