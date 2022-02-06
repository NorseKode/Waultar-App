import 'dart:io';

import 'package:objectbox/objectbox.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/appsettings_entity.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

import 'package:path/path.dart' as dart_path;
// import 'objectbox.g.dart';

class ObjectBoxMock implements ObjectBox {
  @override
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
    final store = await openStore(directory: 'test/objectbox');
    return ObjectBoxMock._create(store);
  }
}

Future<void> deleteTestDb() async {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final datafile =
      File(dart_path.normalize('${scriptDir.path}/test/objectbox/data.mdb'));
  final lockfile =
      File(dart_path.normalize('${scriptDir.path}/test/objectbox/lock.mdb'));
  try {
    await datafile.delete();
    await lockfile.delete();
  } catch (e) {
    // ignore: avoid_print
    print(e);
    return;
  }
}
