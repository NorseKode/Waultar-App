import 'dart:io';

import 'package:path/path.dart' as path_dart;

class AssetsHelper {
  static String getPathToAILib() {
    return path_dart
      .normalize(
        path_dart.join(
          path_dart.dirname(Platform.script.path),
          "lib",
          "assets",
          "ai_models",
        ),
      )
      .substring(1);
  }
}