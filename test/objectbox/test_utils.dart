import 'dart:io';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:path/path.dart' as dart_path;

class TestUtils {
  static Future<ObjectBox> createTestDb() async {
    return ObjectBox.create('test/objectbox');
  }

  static Future<void> deleteTestDb() async {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final datafile =
        File(dart_path.normalize('${scriptDir.path}/test/objectbox/data.mdb'));
    final lockfile =
        File(dart_path.normalize('${scriptDir.path}/test/objectbox/lock.mdb'));
    try {
      await datafile.delete();
      await lockfile.delete();
    } catch (e) {
      return;
    }
  }
}
