import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as dart_path;
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/core/helpers/PathHelper.dart';
import 'package:waultar/startup.dart';

class FileUploader {
  /// Returns file with if user picks a file, otherwise it returns `null`
  static Future<File?> uploadSingle() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  /// Returns a list of files if users picks any file, returns `null` otherwise
  static Future<List<File>?> uploadMultiple() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    } else {
      return null;
    }
  }

  /// Returns a list of files if users picks a directory, returns `null` otherwise
  static Future<List<File>?> uploadFilesFromDirectory() async {
    String? path = await FilePicker.platform.getDirectoryPath();

    if (path != null) {
      return await _getAllFilesFrom(path);
    } else {
      return null;
    }
  }

  static Future<String?> uploadDirectory() async {
    String? path = await FilePicker.platform.getDirectoryPath();

    return path;
  }

  static Future<List<File>> _getAllFilesFrom(String path) async {
    var dir = Directory(path);
    List<File> files = [];

    await dir.list(recursive: true, followLinks: false).forEach((element) async {
      var stat = await element.stat();
      var isFile = stat.type == FileSystemEntityType.file;

      if (isFile) {
        files.add(File(element.path));
      }
    });

    return files;
  }

  static Future<List<String>> getAllFilesFrom(String path) async {
    var dir = Directory(path);
    List<String> files = [];

    await dir.list(recursive: true, followLinks: false).forEach((element) async {
      var stat = await element.stat();
      var isFile = stat.type == FileSystemEntityType.file;

      if (isFile) {
        files.add(element.path.split(path)[1]);
      }
    });

    return files;
  }

  static List<String> extractZip(String zipPath, String serviceName, String profileName) {
          PerformanceHelper? performance;
      var fileCount = 0;
      var appLogger = locator.get<BaseLogger>(instanceName: 'logger');
      // var isPerformanceTracking = data.isPerformanceTracking;

      // if (isPerformanceTracking) {
      //   performance = locator.get<PerformanceHelper>(instanceName: 'performance');
      //   performance.reInit(newParentKey: 'Extract zip');
      //   performance.start();
      // }

      // using inputFileStream to access zip without storing it in memory
      final inputStream = InputFileStream(zipPath);
      
      // decode the zip via the stream - the archive will have the contents of the zip
      // without having to store it in memory

      // if (isPerformanceTracking) {
      //   performance!.addChildDataPointTimer();
      // }
      final archive = ZipDecoder().decodeBuffer(inputStream);
      // if (isPerformanceTracking) {
      //   performance!.addChildToDataPointReading(0, "Decoding of files from zip");
      // }

      // Send total count back
      // mainSendPort.send(MainUnzipTotalCountPackage(archive.files.length));
      var extractsPath = locator.get<String>(instanceName: 'extracts_folder');
      String tempDestDirPath = extractsPath + "/" + profileName;
      final destDirPath = dart_path.normalize(tempDestDirPath);

      var list = <String>[];
      for (var file in archive.files) {
        // only take the files and skip the optional .zip.enc file
        if (file.isFile && !file.name.endsWith('zip.enc')) {
          appLogger.logger.info("extracted file: ${file.name}");
          // if (isPerformanceTracking) {
          //   fileCount++;
          //   performance!.resetChild();
          //   performance.startChild();
          // }

          var filePath = dart_path.normalize(destDirPath + '/' + file.name);
          final outputStream = OutputFileStream(filePath);
          file.writeContent(outputStream);

          // if (list.isNotEmpty && !PathHelper.hasCommonPath(list[list.length - 1], outputStream.path)) {
          //   mainSendPort.send(MainUnzippedPathsPackage(list, list.length));

          //   list = [outputStream.path];
          // }

          // if (isPerformanceTracking) {
          //   performance!.addChildReading(metadata: {'filename': outputStream.path});
          // }

          if (outputStream.path.endsWith(".json")) {
            list.add(outputStream.path);
          }
          outputStream.close();
        }
      }
      // mainSendPort.send(MainUnzippedPathsPackage(list, list.length));
      inputStream.close();
      appLogger.logger.info("Finished extracting");
      return list;
      // if (isPerformanceTracking) {
      //   performance!.stopParentAndWriteToFile(
      //     "zip-extract",
      //     metadata: {"filecount": fileCount},
      //   );
      // }
  }
}

/// Extract a zip folder to a given location and returns a list of strings as
/// the pats to the extracted files
///
/// In order to run on a separate thread the [input] are strings from a
/// `Map<String, String>`. The map expects the following keys
///
/// ```
/// 'path': path to zip file,
/// 'extracts_folder': path to folder where files should be extracted to
/// 'service_name': name of service being extracted
/// 'is_performance_tracking': toString() of a bool value
/// 'log_folder': path to the log folder
/// ```
List<String> extractZip(Map<String, String> input) {
  PerformanceHelper? performance;
  var fileCount = 0;
  var isPerformanceTracking = input["is_performance_tracking"] == "true";

  // if (isPerformanceTracking) {
  //   performance = PerformanceHelper(
  //       pathToPerformanceFile: input['log_folder']!,
  //       // parentKey: "Extract zip",
  //       childKey: "Single file");
  //   performance.reInit(newParentKey: "Extract zip");
  //   performance.start();
  // }

  // using inputFileStream to access zip without storing it in memory
  final inputStream = InputFileStream(input['path'] as String);
  final serviceName = input['service_name'] as String;
  // decode the zip via the stream - the archive will have the contents of the zip
  // without having to store it in memory

  // if (isPerformanceTracking) {
  //   performance!.addChildDataPointTimer();
  // }
  final archive = ZipDecoder().decodeBuffer(inputStream);
  // if (isPerformanceTracking) {
  //   performance!.addChildToDataPointReading(0, "Decoding of files from zip");
  // }

  // performance end

  String tempDestDirPath = input["extracts_folder"]! + "/" + serviceName;
  final destDirPath = dart_path.normalize(tempDestDirPath);

  var lastIndex = 0;
  var list = <String>[];
  for (var file in archive.files) {
    // only take the files and skip the optional .zip.enc file
    if (file.isFile && !file.name.endsWith('zip.enc')) {
      // if (isPerformanceTracking) {
      //   fileCount++;
      //   performance!.resetChild();
      //   performance.startChild();
      // }

      var filePath = dart_path.normalize(destDirPath + '/' + file.name);
      if (!PathHelper.hasCommonPath(list[list.length], filePath)) {
        for (; lastIndex < list.length; lastIndex++) {
          // parse here
        }
      }

      final outputStream = OutputFileStream(filePath);
      file.writeContent(outputStream);

      // if (isPerformanceTracking) {
      //   performance!.addChildReading(metadata: {'filename': outputStream.path});
      // }

      list.add(outputStream.path);
      outputStream.close();
    }
  }

  inputStream.close();
  list.sort();

  // if (isPerformanceTracking) {
  //   performance!.stopParentAndWriteToFile(
  //     "zip-extract",
  //     metadata: {"filecount": fileCount},
  //   );
  // }

  return list;
}
