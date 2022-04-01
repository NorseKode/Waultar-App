import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as dart_path;

class PerformanceHelper {
  String pathToPerformanceFile;
  late String parentKey;
  late PerformanceDataPoint _parentDataPoint;
  final _parentTimer = Stopwatch();
  String? childKey;
  final _childTimer = Stopwatch();
  List<Stopwatch> _watches = <Stopwatch>[];

  PerformanceHelper({
    required this.pathToPerformanceFile,
    this.childKey,
  });

  void reInit({required String newParentKey, String? newChildKey}) {
    parentKey = newParentKey;
    if (newChildKey != null) {
      childKey = newChildKey;
    }
    _parentDataPoint = PerformanceDataPoint(
      key: parentKey,
      timeFormat: "milliseconds",
    );
  }

  void start() {
    _parentTimer.start();
  }

  Duration stop() {
    _parentTimer.stop();
    return _parentTimer.elapsed;
  }

  void startChild() {
    _childTimer.start();
  }

  void stopChild() {
    _childTimer.stop();
  }

  resetChild() {
    _childTimer.reset();
  }

  void addChildReading({Map<String, dynamic>? metadata}) {
    _parentDataPoint.childs.add(PerformanceDataPoint(
      key: childKey!,
      timeFormat: "milliseconds",
      inputTime: _childTimer.elapsed,
      metaData: metadata,
    ));
  }

  void addChildDataPointTimer() {
    _watches.add(Stopwatch());
    _watches[0].start();
  }

  void addChildToDataPointReading(int index, String key, {Map<String, dynamic>? metadata}) {
    _watches[index].stop();
    var elapsed = _watches[index].elapsed;

    _parentDataPoint.childs.add(
      PerformanceDataPoint(
        key: key,
        timeFormat: "milliseconds",
        inputTime: elapsed,
        metaData: metadata,
      ),
    );
  }

  /// Stops the parent timer, write results to a json file with [fileName]
  /// with optional [metadata]
  ///
  /// This also disposes the performance helper, and when it should be used
  /// again, a call to reInit should be made
  void stopParentAndWriteToFile(String fileName, {Map<String, dynamic>? metadata}) {
    stop();
    var elapsed = _parentTimer.elapsed;
    _parentDataPoint.elapsedTime = elapsed;

    if (metadata != null) {
      _parentDataPoint.metadata.addAll(metadata);
    }

    _summary(fileName, parentKey);
  }

  void _summary(
    String summaryFileName,
    String wholeIdentifier,
  ) {
    var summaryFile = File(
      dart_path.normalize(
        dart_path.join(
          pathToPerformanceFile,
          "${DateTime.now().millisecondsSinceEpoch.toString()}-$summaryFileName.json",
        ),
      ),
    );

    summaryFile.createSync(recursive: true);
    summaryFile.writeAsStringSync(jsonEncode(_parentDataPoint.toMap()));

    dispose();
  }

  void dispose() {
    parentKey = "";
    childKey = "";
    _parentTimer.reset();
    _childTimer.reset();
    _parentDataPoint.childs = <PerformanceDataPoint>[];
    _watches = <Stopwatch>[];
  }
}

class PerformanceDataPoint {
  String key;
  String timeFormat;
  late Duration elapsedTime;
  late Map<String, dynamic> metadata;
  late List<PerformanceDataPoint> childs;

  PerformanceDataPoint(
      {required this.key,
      required this.timeFormat,
      Duration? inputTime,
      Map<String, dynamic>? metaData,
      List<PerformanceDataPoint>? inputChilds}) {
    if (inputTime != null) {
      elapsedTime = inputTime;
    } else {
      elapsedTime = const Duration(seconds: 0);
    }

    if (metaData != null) {
      metadata = metaData;
    } else {
      metadata = <String, dynamic>{};
    }

    if (inputChilds != null) {
      childs = inputChilds;
    } else {
      childs = <PerformanceDataPoint>[];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'elapsedTime': elapsedTime.inMilliseconds,
      'timeFormat': timeFormat,
      'metadata': metadata,
      'childs': childs.map((e) => e.toMap()).toList(),
    };
  }
}