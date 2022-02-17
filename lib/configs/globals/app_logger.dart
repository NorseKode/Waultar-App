import 'dart:io';

import 'package:logging/logging.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

import 'os_enum.dart';

class AppLogger {
  final Logger logger = Logger("Logger");
  final OS os;
  String? _testPath;

  AppLogger(this.os) {
    logger.onRecord.listen((event) {
      _writeToLogFile(event.message, event.level, DateTime.now(),
          exception: event.error, stackTrace: event.stackTrace);
    });
  }

  AppLogger.test(this.os, this._testPath);

  setLogLevelRelease() {
    Logger.root.level = Level.SEVERE;
  }

  _writeToLogFile(
    String message,
    Level logLevel,
    DateTime time, {
    Object? exception,
    StackTrace? stackTrace,
  }) {
    var file =
        File(_testPath ?? dart_path.normalize(locator.get<String>(instanceName: 'log_folder') + "/logs.txt"));

    file.writeAsString(
        "time: $time, level: ${logLevel.name}, message: $message, exception: $exception, stackTrace: $stackTrace",
        mode: FileMode.append);
  }
}
