import 'dart:async';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/startup.dart';

import 'test_helper.dart';

Future<void> main() async {
  await TestHelper.runStartupScript();

  var worker = BaseWorker(
    mainHandler: print,
    initiator: IsolateInitiator(testing: true),
  );
  worker.init(isolateMessageHandler);

  await Future.delayed(Duration(seconds: 10));
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
