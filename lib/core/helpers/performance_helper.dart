import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as dart_path;
import 'package:tuple/tuple.dart';

abstract class IPerformanceHelper {
  late String pathToPerformanceFile;
  late String parentKey;
  late PerformanceDataPoint parentDataPoint;

  IPerformanceHelper({required this.pathToPerformanceFile});

  void init({required String newParentKey});

  void startReading(String key);
  Duration stopReading(String key);

  void addData(String key,
      {Duration? duration, List<PerformanceDataPoint>? childs, Map<String, dynamic>? metadata});
  void addDataPoint(String successorKey, PerformanceDataPoint performanceDataPoint);

  void addReading(String successorKey, String key, Duration elapsedTime, {Map<String, dynamic>? metadata});
  void addReadings(String successorKey, String key, List<PerformanceDataPoint> childs);

  void storeDataPoint(String key, PerformanceDataPoint dataPoint);
  List<PerformanceDataPoint> getStoredDataPoints(String key);
  void clearDataPointStore();

  void summary(String summaryFileName);

  void dispose();
}

class PerformanceHelper extends IPerformanceHelper {
  var _timers = <String, Stopwatch>{};
  var _tempStorageList = <Tuple2<String, List<PerformanceDataPoint>>>[
    const Tuple2("", <PerformanceDataPoint>[])
  ];

  PerformanceHelper({
    required String pathToPerformanceFile,
  }) : super(pathToPerformanceFile: pathToPerformanceFile);

  @override
  void init({required String newParentKey}) {
    parentKey = newParentKey;
    _timers.addAll({newParentKey: Stopwatch()});

    parentDataPoint = PerformanceDataPoint(
      key: parentKey,
      timeformat: "milliseconds",
      metaData: <String, dynamic>{},
    );
  }

  @override
  void startReading(String key) {
    if (_timers[key] == null) {
      _timers.addAll({key: Stopwatch()});
    }

    _reset(key);
    _start(key);
  }

  void _start(String key) {
    _getSpecificTimer(key).start();
  }

  @override
  Duration stopReading(String key) {
    var specificTimer = _getSpecificTimer(key);
    specificTimer.stop();
    return specificTimer.elapsed;
  }

  void _reset(String key) {
    _getSpecificTimer(key).reset();
  }

  @override
  void addReading(String successorKey, String key, Duration elapsedTime, {Map<String, dynamic>? metadata}) {
    _addReading(super.parentDataPoint, successorKey, key, elapsedTime, metadata: metadata);
  }

  @override
  void addReadings(String successorKey, String key, List<PerformanceDataPoint> childs) {
    for (var child in childs) {
      addReading(successorKey, key, child.elapsedTime, metadata: child.metadata);
    }
  }

  _addReading(PerformanceDataPoint node, String successorKey, String key, Duration elapsedTime, {Map<String, dynamic>? metadata}) {
    if (node.key == successorKey) {
      node.childs.add(PerformanceDataPoint(key: key, inputTime: elapsedTime, metaData: metadata));
    } else {
      for (var child in node.childs) {
        _addReading(node, successorKey, key, elapsedTime);
      }
    }
  }

  @override
  void addData(
    String key, {
    Duration? duration,
    List<PerformanceDataPoint>? childs,
    Map<String, dynamic>? metadata,
  }) {
    _addData(super.parentDataPoint, key,
        duration: duration, childs: childs, metadata: metadata);
  }

  _addData(
    PerformanceDataPoint node,
    String key, {
    Duration? duration,
    List<PerformanceDataPoint>? childs,
    Map<String, dynamic>? metadata,
  }) {
    if (key == node.key) {
      if (duration != null) {
        node.elapsedTime = duration;
      }
      if (childs != null) {
        node.childs.addAll(childs);
      }
      if (metadata != null) {
        node.metadata.addAll(metadata);
      }
    } else {
      for (var child in node.childs) {
        _addData(child, key, duration: duration, childs: childs, metadata: metadata);
      }
    }
  }

  @override
  void addDataPoint(String successorKey, PerformanceDataPoint performanceDataPoint) {
    _addDataPoint(super.parentDataPoint, successorKey, performanceDataPoint);
  }

  _addDataPoint(PerformanceDataPoint successor, String successorKey, PerformanceDataPoint performanceDataPoint) {
    if (successor.key == successorKey) {
      successor.childs.add(performanceDataPoint);
    } else {
      for (var child in successor.childs) {
        _addDataPoint(child, successorKey, performanceDataPoint);
      }
    }
  }

  @override
  void storeDataPoint(String key, PerformanceDataPoint dataPoint) {
    if (_tempStorageList.any((element) => element.item1 == key)) {
      _tempStorageList.firstWhere((element) => element.item1 == key).item2.add(dataPoint);
    } else {
      _tempStorageList.add(Tuple2(key, [dataPoint]));
    }
  }

  @override
  List<PerformanceDataPoint> getStoredDataPoints(String key) {
    return _tempStorageList.firstWhere((element) => element.item1 == key).item2;
  }

  @override
  void clearDataPointStore() {
    _tempStorageList = <Tuple2<String, List<PerformanceDataPoint>>>[
      const Tuple2("", <PerformanceDataPoint>[])
    ];
  }

  @override
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

  @override
  void dispose() {
    parentKey = "";
    parentDataPoint = PerformanceDataPoint(key: "", timeformat: "");

    for (var timer in _timers.values) {
      timer.stop();
      timer.reset();
    }

    _timers = <String, Stopwatch>{};
    clearDataPointStore();
  }

  Stopwatch _getSpecificTimer(String key) {
    return _timers[key]!;
  }
}

class PerformanceDataPoint {
  String key;
  late String timeFormat;
  late Duration elapsedTime;
  late Map<String, dynamic> metadata;
  late List<PerformanceDataPoint> childs;

  PerformanceDataPoint(
      {required this.key,
      String? timeformat,
      Duration? inputTime,
      Map<String, dynamic>? metaData,
      List<PerformanceDataPoint>? inputChilds}) {
    if (timeformat != null) {
      timeFormat = timeformat;
    } else {
      timeFormat = "milliseconds";
    }
    
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

  PerformanceDataPoint.fromMap(Map<String, dynamic> jsonMap)
      : key = jsonMap["key"],
        timeFormat = jsonMap["timeFormat"],
        elapsedTime = Duration(milliseconds: jsonMap["elapsedTime"]),
        childs = jsonMap["childs"] != null
            ? (jsonMap["childs"])
                .map<PerformanceDataPoint>((e) => PerformanceDataPoint.fromMap(e))
                .toList() as List<PerformanceDataPoint>
            : <PerformanceDataPoint>[],
        metadata = jsonMap["metadata"];

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
