import 'dart:io';

import 'package:logging/logging.dart';

import 'os_enum.dart';

class AppLogger {
  final Logger logger = Logger("Logger");
  final OS os;

  AppLogger(this.os) {
    logger.onRecord.listen((event) {
      // _writeToLogFile(message, logLevel, time)
    });
  }

  setLogLevelRelease() {
    Logger.root.level = Level.SEVERE;
  }

  _writeToLogFile(
    String message,
    Level logLevel,
    DateTime time, {
    Exception? exception,
    StackTrace? stackTrace,
  }) {
    var file = File("");

    file.writeAsString(
        "time: $time, level: ${logLevel.name}, message: $message, exception: $exception, stackTrace: $stackTrace",
        mode: FileMode.append);
  }
}
