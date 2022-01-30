import 'dart:ffi';
import 'dart:io';
import 'package:sqlite3/open.dart';

class SqliteService {

  void init() {
    open.overrideFor(OperatingSystem.windows, _openOnWindows);
  }

  DynamicLibrary _openOnWindows() {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final libraryNextToScript =
        File('${scriptDir.path}/lib/assets/sqlite/sqlite3.dll');
    return DynamicLibrary.open(libraryNextToScript.path);
  }

  // TODO : make override for linux as well
  // should be the same as for windows but with a sqlite3.so binary instead
  // just place the .so file in assets next to the .dll
}
