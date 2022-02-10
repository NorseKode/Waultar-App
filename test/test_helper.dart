import 'dart:io';

import 'package:path/path.dart' as path_dart;

class TestHelper {
  static String pathToCurrentFile() {
    return path_dart
      .normalize(path_dart.join(path_dart.dirname(Platform.script.path), "test", "parser"))
      .substring(1);
  }
}