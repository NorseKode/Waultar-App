import 'dart:convert';

import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/helpers/performance_helper.dart';

class IsolateStandardStartupPackage extends InitiatorPackage {
  bool isPerformanceTracking;
  bool isTestAll;

  IsolateStandardStartupPackage({
    required this.isPerformanceTracking,
    required this.isTestAll,
  });
}

class MainPerformanceMeasurementPackage {
  String performanceDataPointJson;

  MainPerformanceMeasurementPackage({required this.performanceDataPointJson});
  MainPerformanceMeasurementPackage.fromPerformanceDataPoint(
      {required PerformanceDataPoint performanceDataPoint})
      : performanceDataPointJson = jsonEncode(performanceDataPoint.toMap());
}
