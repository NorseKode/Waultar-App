import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as dart_path;

class PerformanceHelper2 {
  String pathToPerformanceFile;
  late String parentKey;
  late PerformanceDataPoint parentDataPoint;
  late List<PerformanceDataPoint> childsData;
  var _timers = <String, Stopwatch>{};

  PerformanceHelper2({
    required this.pathToPerformanceFile,
  }) {
    childsData = <PerformanceDataPoint>[];
  }

  void reInit({required String newParentKey}) {
    parentKey = newParentKey;
    childsData = <PerformanceDataPoint>[];
    _timers.addAll({newParentKey: Stopwatch()});
    parentDataPoint = PerformanceDataPoint(
      key: parentKey,
      timeFormat: "milliseconds",
      metaData: <String, dynamic>{},
    );
  }

  void startReading(String key) {
    if (_timers[key] == null) {
      _timers.addAll({key: Stopwatch()});
    }

    reset(key);
    start(key);
  }

  void start(String key) {
    _getSpecificTimer(key).start();
  }

  Duration stop(String key) {
    var specificTimer = _getSpecificTimer(key);
    specificTimer.stop();
    return specificTimer.elapsed;
  }

  void reset(String key) {
    _getSpecificTimer(key).reset();
  }

  void addParentReading({Map<String, dynamic>? metadata}) {
    parentDataPoint.elapsedTime = stop(parentKey);

    if (metadata != null) {
      parentDataPoint.metadata.addAll(metadata);
    }
  }

  // void addChildReading(String key, {Map<String, dynamic>? metadata}) {
  //   parentDataPoint.childs.add(PerformanceDataPoint(
  //     key: key,
  //     timeFormat: "milliseconds",
  //     inputTime: stop(key),
  //     metaData: metadata,
  //   ));
  // }

  bool addReading(
    String predecessorKey,
    String key, {
    Map<String, dynamic>? metadata,
    PerformanceDataPoint? data,
  }) {
    if (parentKey == predecessorKey) {
      parentDataPoint.childs.add(data ?? PerformanceDataPoint(
        key: key,
        timeFormat: "milliseconds",
        inputTime: stop(key),
        metaData: metadata,
      ));

      return true;
    } else {
      for (var childNode in parentDataPoint.childs) {
        return _addReading(childNode, key, metadata: metadata, data: data);
      }
    }

    return false;
  }

  bool _addReading(
    PerformanceDataPoint previousNode,
    String key, {
    Map<String, dynamic>? metadata,
    PerformanceDataPoint? data,
  }) {
    if (previousNode.key == previousNode.key) {
      previousNode.childs.add(data ?? PerformanceDataPoint(
        key: key,
        timeFormat: "milliseconds",
        inputTime: stop(key),
        metaData: metadata,
      ));

      return true;
    } else {
      for (var childNode in previousNode.childs) {
        var res = _addReading(childNode, key);

        if (res) {
          return res;
        }
      }
    }

    return false;
  }

  Stopwatch _getSpecificTimer(String key) {
    return _timers[key]!;
  }

  /// Stops the parent timer, write results to a json file with [fileName]
  /// with optional [metadata]
  ///
  /// This also disposes the performance helper, and when it should be used
  /// again, a call to reInit should be made
  // void stopParentAndWriteToFile(String fileName, {Map<String, dynamic>? metadata}) {
  //   stop();
  //   var elapsed = _parentTimer.elapsed;
  //   parentDataPoint.elapsedTime = elapsed;

  //   if (metadata != null) {
  //     parentDataPoint.metadata.addAll(metadata);
  //   }

  //   _summary(fileName, parentKey);
  // }

  void summary(String summaryFileName) {
    var summaryFile = File(
      dart_path.normalize(
        dart_path.join(
          pathToPerformanceFile,
          "${DateTime.now().millisecondsSinceEpoch.toString()}-$summaryFileName.json",
        ),
      ),
    );

    summaryFile.createSync(recursive: true);
    summaryFile.writeAsStringSync(jsonEncode(parentDataPoint.toMap()));

    dispose();
  }

  void dispose() {
    parentKey = "";
    parentDataPoint = PerformanceDataPoint(key: "", timeFormat: "");

    for (var timer in _timers.values) {
      timer.stop();
      timer.reset();
    }

    _timers = <String, Stopwatch>{};
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
