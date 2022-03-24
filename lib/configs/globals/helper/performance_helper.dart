import 'dart:io';

import 'package:waultar/configs/globals/app_logger.dart';
import 'package:path/path.dart' as dart_path;

class PerformanceHelper {
  String pathToPerformanceFile;
  // late File _file;
  final _parentTimer = Stopwatch();
  String parentKey;
  int _parentTimeSpent = 0;

  PerformanceHelper({required this.pathToPerformanceFile, required this.parentKey}) {
    // _file = File(pathToPerformanceFile + "/temp.txt");

    // if (!_file.existsSync()) {
    //   _file.createSync(recursive: true);
    // }
  }

  void start() {
    _parentTimer.start();
  }

  Duration stop() {
    _parentTimer.stop();
    return _parentTimer.elapsed;
  }

  void reset() {
    _parentTimer.reset();
  }

  // Duration stopAndWriteToFile(String identifier) {
  // }

  void stopParentAndWriteToFile(String fileName, {String? metadata}) {
    _parentTimer.stop();
    var elapsed = _parentTimer.elapsed;
    _parentTimeSpent = elapsed.inMilliseconds;
    // _file.writeAsStringSync("$parentKey;${elapsed.inMilliseconds}\n", mode: FileMode.append);
    _summary(fileName, parentKey);
  }

  void _summary(String summaryFileName, String wholeIdentifier, {String? individualIdentifier, String? metadata}) {
    var summaryFile = File(
      dart_path.normalize(
        dart_path.join(
          pathToPerformanceFile,
          "${DateTime.now().millisecondsSinceEpoch.toString()}-$summaryFileName.txt",
        ),
      ),
    );
    var individualCount = 0;
    var individualSummedTimeMs = 0;
    var wholeTimeSpent = "";

    summaryFile.createSync();

    // for (var line in _file.readAsLinesSync()) {
    //   if (individualIdentifier != null) {
    //     if (line.startsWith(individualIdentifier)) {
    //       individualCount++;
    //       individualSummedTimeMs += int.parse(line.split(";")[1]);
    //     }
    //   } else if (line.startsWith(wholeIdentifier)) {
    //     wholeTimeSpent = line.split(";")[1];
    //   }
    // }

    summaryFile.writeAsStringSync("Summary of $parentKey\n", mode: FileMode.append);
    summaryFile.writeAsStringSync("Finished in $_parentTimeSpent milliseconds\n", mode: FileMode.append);
    // if (individualIdentifier != null) {
    //   summaryFile.writeAsStringSync("with $individualCount elements\n", mode: FileMode.append);
    //   summaryFile.writeAsStringSync("and a summed time of $individualSummedTimeMs\n", mode: FileMode.append);
    // }
    if (metadata != null) {
      summaryFile.writeAsStringSync("Metadata: $metadata", mode: FileMode.append);
    }
  }

  // void dispose() {
  //   _file.writeAsStringSync("");
  // }
}

// class PerformanceDataPointBase {
//   String key;
//   Duration elapsedTime;
//   List<PerformanceDataPointChild> childs;

//   PerformanceDataPointBase({required this.key, required this.elapsedTime, required this.childs});
// }

// class PerformanceDataPointChild{

// }