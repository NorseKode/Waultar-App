import 'package:waultar/configs/globals/app_logger.dart';

class PerformanceHelper {
  final AppLogger appLogger;
  final _timer = Stopwatch();

  PerformanceHelper(this.appLogger);

  void start() {
    _timer.start();
  }

  Duration stop() {
    _timer.stop();
    return _timer.elapsed;
  }

  void reset() {
    _timer.reset();
  }

  Duration stopAndReset() {
    _timer.stop();
    var elapsed = _timer.elapsed;
    _timer.reset();
    return elapsed;
  }

  Duration stopAndLog(String message, {String? identifier}) {
    _timer.stop();
    var elapsed = _timer.elapsed;
    logRunTime(elapsed, message, identifier: identifier);
    return elapsed;
  }
  
  Duration stopResetAndLog(String message, {String? identifier}) {
    _timer.stop();
    _timer.reset();
    var elapsed = _timer.elapsed;
    logRunTime(elapsed, message, identifier: identifier);
    return elapsed;
  }

  void logRunTime(Duration elapsed, String message, {String? identifier}) {
    var runTime = elapsed.inMilliseconds;
    appLogger.logger.shout("${identifier != null ? identifier + " " : ""}$message, took $runTime milliseconds");
  }

  void logTimeSummary(String messageToLookFor) {
    // appLogger.
  }
}
