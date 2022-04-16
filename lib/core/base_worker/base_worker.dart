import 'dart:isolate';

import 'package:easy_isolate/easy_isolate.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/startup.dart';

class BaseWorker {
  BaseWorker({
    required this.mainHandler,
    required this.initiator,
  });

  final BaseLogger _logger = locator.get<BaseLogger>(instanceName: 'logger');
  final worker = Worker();
  Function(dynamic data) mainHandler;
  InitiatorPackage initiator;

  /// Initiate the worker (new thread) and start listen from messages between the two
  Future<void> init(IsolateMessageHandler workerBody) async {
    await worker.init(
      _mainMessageHandler,
      workerBody,
      errorHandler: print,
      initialMessage: initiator,
      queueMode: true,
    );
  }

  /// Handle the messages coming from the isolate
  void _mainMessageHandler(dynamic data, SendPort isolateSendPort) {
    if (data is LogRecordPackage) {
      _logger.logger.info(data.value, data.error);
    } else {
      mainHandler(data);
    }
  }

  dynamic sendMessage(dynamic package) {
    worker.sendMessage(package);
  }

  void dispose() {
    worker.dispose();
  }
}
