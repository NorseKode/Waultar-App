import 'dart:io';

import 'package:path/path.dart' as path_dart;
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/startup.dart';

class TestHelper {
  // static final _locator = GetIt.instance;
  static final _logFilePath = path_dart
      .normalize(
          path_dart.join(path_dart.dirname(Platform.script.path), "test", "parser") + "/logs.txt")
      .substring(1);
  static final _appLogger = AppLogger.test(detectPlatform(), _logFilePath);

  static String pathToCurrentFile() {
    return path_dart
        .normalize(path_dart.join(path_dart.dirname(Platform.script.path), "test", "parser"))
        .substring(1);
  }

  static void createTestLogger() {
    locator.registerSingleton<AppLogger>(_appLogger, instanceName: 'logger');
  }

  static void clearTestLogger() {
    var file = File(_logFilePath);
    file.writeAsStringSync("");
  }
}
