import 'dart:io';

import 'package:logging/logging.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

import 'os_enum.dart';

class AppLogger {
  final Logger logger = Logger("Logger");
  final OS os;
  String? _testPath;
  late File _logFile;

  AppLogger(this.os, String logFolder, {Level? level}) {
    _logFile =
        File(dart_path.normalize(logFolder + "/logs.txt"));

    if (level != null) {
      Logger.root.level = level;
    }

    logger.onRecord.listen((event) {
      _logFile.writeAsStringSync(
          "time: ${event.time}, level: ${event.level.name}, message: ${event.message}, exception: ${event.error}, stackTrace: ${event.stackTrace}\n",
          mode: FileMode.append);
    });
  }

  AppLogger.test(this.os, this._testPath) {
    _logFile = _logFile = File(_testPath!);
  }

  setLogLevelRelease() {
    LOGLEVEL = Level.SEVERE;
    Logger.root.level = Level.SEVERE;
  }

  changeLogLevel(Level level) {
    Logger.root.level = level;
  }

  // readLogFile() {
  //   _logFile.
  // }
}
