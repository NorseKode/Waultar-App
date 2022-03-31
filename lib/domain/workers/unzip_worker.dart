import 'dart:convert';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/helpers/performance_helper2.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/domain/workers/shared_packages.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

Future unzipWorkerBody(dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is IsolateUnzipStartPackage) {
    try {
      await setupIsolate(mainSendPort, data, data.waultarPath);
      PerformanceHelper2? performance;
      var fileCount = 0;
      var isPerformanceTracking = data.isPerformanceTracking;
      var isTestAll = data.isTrackAll;

      if (isPerformanceTracking && isTestAll) {
        performance = locator.get<PerformanceHelper2>(instanceName: 'performance2');
      }

      // using inputFileStream to access zip without storing it in memory
      final inputStream = InputFileStream(data.pathToZip);
      final profileName = data.profileName;

      // decode the zip via the stream - the archive will have the contents of the zip
      // without having to store it in memory

      if (isPerformanceTracking && isTestAll) {
        performance!.startReading("Decode of zip");
      }
      final archive = ZipDecoder().decodeBuffer(inputStream);
      if (isPerformanceTracking && isTestAll) {
        var key = "Decode of zip";
        var elapsed = performance!.stop(key);
        mainSendPort.send(
          MainPerformanceMeasurementPackage.fromPerformanceDataPoint(
            performanceDataPoint: PerformanceDataPoint(
              key: key,
              timeFormat: "milliseconds",
              inputTime: performance.stop(key),
            ),
          ),
        );
      }

      // Send total count back
      mainSendPort.send(MainUnzipTotalCountPackage(archive.files.length));
      var extractsPath = locator.get<String>(instanceName: 'extracts_folder');

      String tempDestDirPath = extractsPath + "/" + profileName;
      final destDirPath = dart_path.normalize(tempDestDirPath);

      var list = <String>[];
      int progress = 0;
      for (var file in archive.files) {
        // only take the files and skip the optional .zip.enc file (facebook specific)
        if (file.isFile && !file.name.endsWith('zip.enc')) {
          var performanceReading = "";
          if (isPerformanceTracking && isTestAll) {
            performance!.startReading("Extracted File");
            fileCount++;
          }

          var filePath = dart_path.normalize(destDirPath + '/' + file.name);
          final outputStream = OutputFileStream(filePath);
          file.writeContent(outputStream);

          // if (list.isNotEmpty && !PathHelper.hasCommonPath(list[list.length - 1], outputStream.path)) {
          //   mainSendPort.send(MainUnzippedPathsPackage(list, list.length));

          //   list = [outputStream.path];
          // }

          if (isPerformanceTracking && isTestAll) {
            var key = "Extracted File";
            var reading = performance!.stop(key);
            performanceReading = jsonEncode(PerformanceDataPoint(
                key: "Extracted File",
                timeFormat: "milliseconds",
                inputTime: reading,
                metaData: <String, dynamic>{
                  "file path": outputStream.path,
                }).toMap());
          }

          if (outputStream.path.endsWith(".json")) {
            list.add(outputStream.path);
          }
          outputStream.close();
          progress = progress + 1;
          mainSendPort.send(MainUnzipProgressPackage(
            progress,
            performanceReading,
          ));
        }
      }
      mainSendPort.send(MainUnzippedPathsPackage(list, list.length));
      inputStream.close();

      if (isPerformanceTracking && isTestAll) {
        performance!.dispose();
      }
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

// isolate modtager denne
class IsolateUnzipStartPackage extends InitiatorPackage {
  String pathToZip;
  String waultarPath;

  // performance configs to be used inside isolate
  bool isPerformanceTracking;
  bool isTrackAll;

  // to be used as root folder name for extracted dump
  String profileName;

  IsolateUnzipStartPackage({
    required this.pathToZip,
    required this.isPerformanceTracking,
    required this.isTrackAll,
    required this.profileName,
    required this.waultarPath,
  });
}

// worker får disse
class MainUnzippedPathsPackage {
  List<String> pathsInSameFolder;
  int parsedCount;
  MainUnzippedPathsPackage(this.pathsInSameFolder, this.parsedCount);
}

class MainUnzipTotalCountPackage {
  int total;
  MainUnzipTotalCountPackage(this.total);
}

class MainUnzipProgressPackage {
  int progress;
  String performanceNode;
  MainUnzipProgressPackage(this.progress, this.performanceNode);
}
