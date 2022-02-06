import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/entities/appsettings_entity.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

// import 'objectbox.g.dart';

class ObjectBoxMock {
  late final Store store;

  ObjectBoxMock._create(this.store) {
    // additional setup code here
    final appSettingsBox = store.box<AppSettingsBox>();
    if (appSettingsBox.isEmpty()) {
      var initialAppSettings = AppSettingsBox(0, false);
      appSettingsBox.put(initialAppSettings);
    }
  }

  static Future<ObjectBoxMock> create() async {
    final store = await openStore(directory: '/');
    return ObjectBoxMock._create(store);
  }
}
