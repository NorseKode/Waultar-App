import 'package:waultar/startup.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';

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

    var facebookService = store
        .box<ServiceObjectBox>()
        .query(ServiceObjectBox_.name.equals('Facebook'))
        .build()
        .findUnique();
    if (facebookService == null) {
      facebookService = ServiceObjectBox(name: 'Facebook', company: 'Meta', image: '/TODO');
      store.box<ServiceObjectBox>().put(facebookService);
    }

    var instagramService = store
        .box<ServiceObjectBox>()
        .query(ServiceObjectBox_.name.equals('Instagram'))
        .build()
        .findUnique();
    if (instagramService == null) {
      instagramService = ServiceObjectBox(name: 'Instagram', company: 'Meta', image: '/TODO');
      store.box<ServiceObjectBox>().put(instagramService);
    }

  }

  static Future<ObjectBox> create() async {
    final store = await openStore(directory: locator.get<String>(instanceName: 'db_folder'));
    return ObjectBox._create(store);
  }
}
