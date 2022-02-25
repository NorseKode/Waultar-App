import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as dart_path;

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

List<String> extractZip(Map<String, String> input) {
  // using inputFileStream to access zip without storing it in memory
  final inputStream = InputFileStream(input['path'] as String);

  // decode the zip via the stream - the archive will have the contents of the zip
  // without having to store it in memory
  final archive = ZipDecoder().decodeBuffer(inputStream);
  String tempDestDirPath = input["extracts_folder"]! + "/";
  final destDirPath = dart_path.normalize(tempDestDirPath);

  var list = <String>[];
  for (var file in archive.files) {
    // only take the files and skip the optional .zip.enc file
    if (file.name.endsWith('zip.enc')) {
      print(file.name);
    }
    if (file.isFile && !file.name.endsWith('zip.enc')) {
      var filePath = dart_path.normalize(destDirPath + '/' + file.name);
      final outputStream = OutputFileStream(filePath);
      file.writeContent(outputStream);
      list.add(outputStream.path);
      outputStream.close();
    }
  }
  print('done unzipping');

  inputStream.close();

  print(list.length);
  return list;
}
