import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as dart_path;
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/helper/performance_helper.dart';
import 'package:waultar/configs/globals/os_enum.dart';
import 'package:logging/logging.dart';
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
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

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

    await dir
        .list(recursive: true, followLinks: false)
        .forEach((element) async {
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

    await dir
        .list(recursive: true, followLinks: false)
        .forEach((element) async {
      var stat = await element.stat();
      var isFile = stat.type == FileSystemEntityType.file;

      if (isFile) {
        files.add(element.path.split(path)[1]);
      }
    });

    return files;
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
  PerformanceHelper? performance1;
  PerformanceHelper? performance2;
  AppLogger? appLogger;
  var isPerformanceTracking = input["is_performance_tracking"] == "true";

  if (isPerformanceTracking) {
    appLogger = AppLogger(detectPlatform(), input["log_folder"]!, level: Level.SEVERE);
    performance1 = PerformanceHelper(appLogger);
    performance2 = PerformanceHelper(appLogger);
    performance1.start();
  }
   
  // using inputFileStream to access zip without storing it in memory
  final inputStream = InputFileStream(input['path'] as String);
  final serviceName = input['service_name'] as String;
  // decode the zip via the stream - the archive will have the contents of the zip
  // without having to store it in memory
  final archive = ZipDecoder().decodeBuffer(inputStream);
  String tempDestDirPath = input["extracts_folder"]! + "/" + serviceName;
  final destDirPath = dart_path.normalize(tempDestDirPath);

  var list = <String>[];
  for (var file in archive.files) {
    // only take the files and skip the optional .zip.enc file
    if (file.isFile && !file.name.endsWith('zip.enc')) {
      if (isPerformanceTracking) {
        performance2!.reset();
        performance2.start();
      }

      var filePath = dart_path.normalize(destDirPath + '/' + file.name);
      final outputStream = OutputFileStream(filePath);
      file.writeContent(outputStream);
      list.add(outputStream.path);
      outputStream.close();

      if (isPerformanceTracking) {
        performance2!.stopAndLog("Copied file with name $filePath from zip");
      }
    }
  }

  inputStream.close();
  list.sort();

  if (isPerformanceTracking) {
    performance1!.stopAndLog("Extracted and sorted entire zip folder");
  }

  return list;
}
