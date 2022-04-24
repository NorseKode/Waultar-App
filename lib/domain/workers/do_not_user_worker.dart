import 'dart:convert';
import 'dart:isolate';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/image_model_enum.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/core/ai/image_classifier_efficient_net_b4.dart';
import 'package:waultar/core/ai/image_classifier_mobilenetv3.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/helpers/do_not_use_helper.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/startup.dart';

Future doNotUseWorkerBody(dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is IsolateDoNotUseStartPackage) {
    try {
      await setupIsolate(mainSendPort, data, data.waultarPath);
      var logger = locator.get<BaseLogger>(instanceName: 'logger');
      var performance = PerformanceHelper(
          pathToPerformanceFile: locator.get<String>(instanceName: 'performance_folder'));
        
      DoNotUseHelper.createMemoryOverflow();
    } catch (e, stacktrace) {
      mainSendPort.send(LogRecordPackage(e.toString(), stacktrace.toString()));
    } finally {
      var _context = locator.get<ObjectBox>(instanceName: 'context');
      _context.store.close();
    }
  }
}

// run setupServices with configuration
// this call enables you to use all normal dependencies, the logger and objectbox
// - it abstracts away that the code being executed is in its own memory space
Future<void> setupIsolate(SendPort sendPort, InitiatorPackage setupData, String waultarPath) async {
  await setupServices(
      testing: setupData.testing, isolate: true, sendPort: sendPort, waultarPath: waultarPath);
}

class IsolateDoNotUseStartPackage extends InitiatorPackage {
  String waultarPath;

  IsolateDoNotUseStartPackage({
    required this.waultarPath,
  });
}

class MainImageClassifyProgressPackage {
  int amountTagged;
  bool isDone;
  String? performanceDataPoint;

  MainImageClassifyProgressPackage({
    required this.amountTagged,
    required this.isDone,
    this.performanceDataPoint,
  });
}
