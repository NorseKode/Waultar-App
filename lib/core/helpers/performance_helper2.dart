import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as dart_path;
import 'package:tuple/tuple.dart';

class PerformanceHelper2 {
  String pathToPerformanceFile;
  late String parentKey;
  late PerformanceDataPoint parentDataPoint;
  var _timers = <String, Stopwatch>{};
  var _tempStorageList = <Tuple2<String, List<PerformanceDataPoint>>>[Tuple2("", <PerformanceDataPoint>[])];

  PerformanceHelper2({
    required this.pathToPerformanceFile,
  });

  void reInit({required String newParentKey}) {
    parentKey = newParentKey;
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

  void storeDataPoint(String key, PerformanceDataPoint dataPoint) {
    if (_tempStorageList.any((element) => element.item1 == key)) {
      _tempStorageList.firstWhere((element) => element.item1 == key).item2.add(dataPoint);
    } else {
      _tempStorageList.add(Tuple2(key, [dataPoint]));
    }
  }
  
  List<PerformanceDataPoint> getStoredDataPoints(String key) {
    return _tempStorageList.firstWhere((element) => element.item1 == key).item2;
  }

  void clearDataPointStore() {
    _tempStorageList = <Tuple2<String, List<PerformanceDataPoint>>>[Tuple2("", <PerformanceDataPoint>[])];
  }

  bool addReading(
    String predecessorKey,
    String key, {
    Map<String, dynamic>? metadata,
    PerformanceDataPoint? data,
    List<PerformanceDataPoint>? childs,
  }) {
    if (parentKey == predecessorKey) {
      parentDataPoint.childs.add(data ??
          PerformanceDataPoint(
            key: key,
            timeFormat: "milliseconds",
            inputTime: stop(key),
            inputChilds: childs,
            metaData: metadata,
          ));

      return true;
    } else {
      for (var childNode in parentDataPoint.childs) {
        return _addReading(childNode, key, metadata: metadata, data: data, childs: childs);
      }
    }

    return false;
  }

  bool _addReading(
    PerformanceDataPoint previousNode,
    String key, {
    Map<String, dynamic>? metadata,
    PerformanceDataPoint? data,
    List<PerformanceDataPoint>? childs,
  }) {
    if (previousNode.key == previousNode.key) {
      previousNode.childs.add(data ??
          PerformanceDataPoint(
            key: key,
            timeFormat: "milliseconds",
            inputTime: stop(key),
            inputChilds: childs,
            metaData: metadata,
          ));

      return true;
    } else {
      for (var childNode in previousNode.childs) {
        var res = _addReading(childNode, key, metadata: metadata, data: data, childs: childs);

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
    clearDataPointStore();
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

  PerformanceDataPoint.fromMap(Map<String, dynamic> jsonMap)
      : key = jsonMap["key"],
        timeFormat = jsonMap["timeFormat"],
        elapsedTime = Duration(milliseconds: jsonMap["elapsedTime"]),
        childs = jsonMap["childs"] != null
          ? (jsonMap["childs"])
            .map<PerformanceDataPoint>((e) => PerformanceDataPoint.fromMap(e))
            .toList()
            as List<PerformanceDataPoint>
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
