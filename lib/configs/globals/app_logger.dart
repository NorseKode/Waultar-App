import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:easy_isolate/easy_isolate.dart';
import 'package:logging/logging.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

import 'os_enum.dart';

class BaseLogger {
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
  SendPort sendPort;

  IsolateLogger(this.sendPort) {
    logger.onRecord.listen((event) {
      final logRecord = LogRecordIsolate(event.toString());
      sendPort.send(logRecord);
    });
  }
}

class LogRecordIsolate {
  String value;
  LogRecordIsolate(this.value);
}

class IsolateInitiator {
  bool testing;
  IsolateInitiator({this.testing = false});
}

class BaseWorker {
  final BaseLogger _logger = locator.get<BaseLogger>(instanceName: 'logger');
  final worker = Worker();

  WorkerListenerTask mainHandler;
  bool testing;
  // IsolateBody workerTask;
  BaseWorker(this.mainHandler, {this.testing = false});

  /// Initiate the worker (new thread) and start listen from messages between the two
  Future<void> init() async {
    await worker.init(
      mainMessageHandler,
      isolateMessageHandler,
      errorHandler: print,
      initialMessage: IsolateInitiator(testing: testing),
      queueMode: true,
    );
  }

  /// Handle the messages coming from the isolate
  void mainMessageHandler(dynamic data, SendPort isolateSendPort) {
    if (data is LogRecordIsolate) {
      _logger.logger.info(data.value);
    } else {
      mainHandler(data);
    }
  }

  dynamic sendMessage(dynamic package) {
    worker.sendMessage(package);
  }
}

Future<void> setupIsolate(SendPort sendPort, IsolateInitiator setupData) async {
  await setupServices(
      testing: setupData.testing, isolate: true, sendPort: sendPort);
}

Future testIsolateMethod(String message) async {
  final BaseLogger _logger = locator.get<BaseLogger>(instanceName: 'logger');
  _logger.logger.info(message);
}

// Handle the messages coming from the main
Future isolateMessageHandler(
    dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is IsolateInitiator) {
    await setupIsolate(mainSendPort, data);
    var _logger = locator.get<BaseLogger>(instanceName: 'logger');
    
    try {
    
      _logger.logger.info('dummy package log');

      await testIsolateMethod('bum');
    } catch (e) {
      _logger.logger.severe(e);
    } finally {
      var _context = locator.get<ObjectBox>(instanceName: 'context');
      _context.store.close();
    }
  }
}

class TestInsider {
  String value;
  TestInsider(this.value);
  String call() => value;
}

typedef WorkerListenerTask = FutureOr Function(dynamic eventFromCreatedIsolate);
