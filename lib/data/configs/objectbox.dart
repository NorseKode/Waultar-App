import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/misc/service_document.dart';
import 'package:path/path.dart' as dart_path;

import '../entities/misc/appsettings_document.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store) {
    // additional setup code here
    final appSettingsBox = store.box<AppSettingsDocument>();
    if (appSettingsBox.count() == 0) {
      var initialAppSettings = AppSettingsDocument(0, false);
      appSettingsBox.put(initialAppSettings);
    }

    var facebookService = store
        .box<ServiceDocument>()
        .query(ServiceDocument_.serviceName.equals('Facebook'))
        .build()
        .findUnique();
    if (facebookService == null) {
      facebookService = ServiceDocument(
          serviceName: 'Facebook',
          companyName: 'Meta',
          image: dart_path.normalize('/assests/service_icons/todo.svg'));
      store.box<ServiceDocument>().put(facebookService);
    }

    var instagramService = store
        .box<ServiceDocument>()
        .query(ServiceDocument_.serviceName.equals('Instagram'))
        .build()
        .findUnique();
    if (instagramService == null) {
      instagramService = ServiceDocument(
          serviceName: 'Instagram',
          companyName: 'Meta',
          image: dart_path.normalize('/assests/service_icons/todo.svg'));
      store.box<ServiceDocument>().put(instagramService);
    }
  }

  static Future<ObjectBox> create(String path) async {
    final store = await openStore(directory: path);
    return ObjectBox._create(store);
  }

  ObjectBox._fromIsolate(this.store);

  static Future<ObjectBox> fromIsolate(String path) async {
    final store = Store.attach(getObjectBoxModel(), path);
    return ObjectBox._fromIsolate(store);
  }
}
