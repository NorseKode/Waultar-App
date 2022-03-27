import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:waultar/configs/globals/helper/performance_helper.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

Future unzipWorkerBody(dynamic data, SendPort mainSendPort, Function onError) async {
  if (data is IsolateUnzipStartPackage) {
    try {
      await setupIsolate(mainSendPort, data, data.waultarPath);
      PerformanceHelper? performance;
      var fileCount = 0;
      var isPerformanceTracking = data.isPerformanceTracking;

      if (isPerformanceTracking) {
        performance = locator.get<PerformanceHelper>(instanceName: 'performance');
        performance.reInit(newParentKey: 'Extract zip');
        performance.start();
      }

      // using inputFileStream to access zip without storing it in memory
      final inputStream = InputFileStream(data.pathToZip);
      final profileName = data.profileName;

      // decode the zip via the stream - the archive will have the contents of the zip
      // without having to store it in memory

      if (isPerformanceTracking) {
        performance!.addChildDataPointTimer();
      }
      final archive = ZipDecoder().decodeBuffer(inputStream);
      if (isPerformanceTracking) {
        performance!.addChildToDataPointReading(0, "Decoding of files from zip");
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
          if (isPerformanceTracking) {
            fileCount++;
            performance!.resetChild();
            performance.startChild();
          }

          var filePath = dart_path.normalize(destDirPath + '/' + file.name);
          final outputStream = OutputFileStream(filePath);
          file.writeContent(outputStream);

          // if (list.isNotEmpty && !PathHelper.hasCommonPath(list[list.length - 1], outputStream.path)) {
          //   mainSendPort.send(MainUnzippedPathsPackage(list, list.length));

          //   list = [outputStream.path];
          // }

          if (isPerformanceTracking) {
            performance!.addChildReading(metadata: {'filename': outputStream.path});
          }

          if (outputStream.path.endsWith(".json")) {
            list.add(outputStream.path);
          }
          outputStream.close();
          progress = progress + 1;
          mainSendPort.send(MainUnzipProgressPackage(progress));
        }
      }
      mainSendPort.send(MainUnzippedPathsPackage(list, list.length));
      inputStream.close();

      if (isPerformanceTracking) {
        performance!.stopParentAndWriteToFile(
          "zip-extract",
          metadata: {"filecount": fileCount},
        );
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
  await setupServices(testing: setupData.testing, isolate: true, sendPort: sendPort, waultarPath: waultarPath);
}

// isolate modtager denne
class IsolateUnzipStartPackage extends InitiatorPackage {
  String pathToZip;
  String waultarPath;

  // performance configs to be used inside isolate
  bool isPerformanceTracking;

  // to be used as root folder name for extracted dump
  String profileName;

  IsolateUnzipStartPackage({
    required this.pathToZip,
    required this.isPerformanceTracking,
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
  MainUnzipProgressPackage(this.progress);
}
