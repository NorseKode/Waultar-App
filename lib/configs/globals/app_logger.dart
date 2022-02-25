import 'dart:io';

import 'package:logging/logging.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

import 'os_enum.dart';

class AppLogger {
  final Logger logger = Logger("Logger");
  final OS os;
  String? _testPath;
  late File _logFile;

  AppLogger(this.os) {
    _logFile =
        File(dart_path.normalize(locator.get<String>(instanceName: 'log_folder') + "/logs.txt"));

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
    Logger.root.level = Level.SEVERE;
  }
}
