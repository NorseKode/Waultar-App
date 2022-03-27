import 'dart:io';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

import 'os_enum.dart';

class BaseLogger {
  final Logger logger = Logger("Logger");
  setLogLevelRelease() {
    Logger.root.level = Level.SEVERE;
  }

  changeLogLevel(Level level) {
    Logger.root.level = level;
  }
}

class AppLogger extends BaseLogger {
  final OS os;
  String? _testPath;
  late File _logFile;

  AppLogger(this.os, {Level? level}) {
    _logFile = File(dart_path.normalize(
        locator.get<String>(instanceName: 'log_folder') + "/logs.txt"));

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
}

class IsolateLogger extends BaseLogger {
  SendPort sendPort;

  IsolateLogger(this.sendPort) {
    logger.onRecord.listen((event) {
      final logRecord = LogRecordPackage(event.toString(), event.error.toString());
      sendPort.send(logRecord);
    });
  }
}
