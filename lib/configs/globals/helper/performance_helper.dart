import 'package:waultar/configs/globals/app_logger.dart';

class PerformanceHelper {
  static void logRunTime(
      DateTime startTime, DateTime endTime, BaseLogger appLogger, String message) {
    var runTime = endTime.microsecondsSinceEpoch - startTime.microsecondsSinceEpoch;
    appLogger.logger.info("$message, took $runTime microseconds");
  }
}
