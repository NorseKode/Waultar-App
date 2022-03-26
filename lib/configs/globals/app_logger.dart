import 'dart:io';
import 'dart:isolate';

import 'package:easy_isolate/easy_isolate.dart';
import 'package:logging/logging.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

import 'os_enum.dart';

abstract class BaseLogger {
  final Logger logger = Logger("Logger");
  setLogLevelRelease() {
    Logger.root.level = Level.SEVERE;
  }
}

class AppLogger extends BaseLogger {
  final OS os;
  String? _testPath;
  late File _logFile;

  AppLogger(this.os) {
    _logFile = File(dart_path.normalize(
        locator.get<String>(instanceName: 'log_folder') + "/logs.txt"));

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
  final SendPort sendPort;

  IsolateLogger(this.sendPort) {
    logger.onRecord.listen((event) {
      // ignore: avoid_print
      print(event);
      final message =
          "time: ${event.time}, level: ${event.level.name}, message: ${event.message}, exception: ${event.error}, stackTrace: ${event.stackTrace}\n";
      final logRecord = LogRecordIsolate(message);
      sendPort.send(logRecord);
    });
  }
}

class LogRecordIsolate {
  String value;
  LogRecordIsolate(this.value);
}

class FilesDownloadWorker {
  FilesDownloadWorker(this.callback, this._logger);

  final Function(dynamic event) callback;
  final IsolateLogger _logger;

  final worker = Worker();

  /// Initiate the worker (new thread) and start listen from messages between
  /// the threads
  Future<void> init() async {
    await worker.init(
      mainMessageHandler,
      isolateMessageHandler,
      errorHandler: print,
    );
    // worker.sendMessage(DownloadItemEvent(item));
  }

  /// Handle the messages coming from the isolate
  void mainMessageHandler(dynamic data, SendPort isolateSendPort) {
    // if (data is dynamic) {
    if (data is LogRecordIsolate) {
      _logger.logger.info(data.value);
    }
  }
  // }

  /// Handle the messages coming from the main
  static isolateMessageHandler(
      dynamic data, SendPort mainSendPort, SendErrorFunction sendError) async {
    // define the algorithm to be used inside the isolate
    //! must be static or top level
    await setupIsolate();
  }
}

// use the sendport when creating an isolate logger
// static builders for needed dependencies - these can vary from the kind of worker that gets spawn
// ignore: unused_element
late final IsolateLogger _isoLogger;
Future<void> setupIsolate() async {
} 

