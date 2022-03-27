import 'package:objectbox/internal.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:path/path.dart' as dart_path;

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
