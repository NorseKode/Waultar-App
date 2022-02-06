import 'package:objectbox/objectbox.dart';

import '../entities/appsettings_entity.dart';
import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store) {
    // additional setup code here
    final appSettingsBox = store.box<AppSettingsBox>();
    if (appSettingsBox.count() == 0) {
      var initialAppSettings = AppSettingsBox(0, false);
      appSettingsBox.put(initialAppSettings);
    }
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }
}
