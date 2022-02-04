import 'dart:io';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
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

  /// Returns a list of files if users picks any file, reutrns `null` otherwise
  static Future<List<File>?> uploadMultiple() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    } else {
      return null;
    }
  }

  /// Returns a list of files if users picks a directory, reutrns `null` otherwise
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

  static Future<List<String>> extractZip(String path) async {
    final bytes = File(path).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    final folder = await getApplicationDocumentsDirectory();

    var list = <String>[];

    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        var path = dart_path.normalize(folder.path + '/extracts/' + filename);
        var finalFile = File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
        print(finalFile.path);
        list.add(finalFile.path);
      } 
    }

    return list;
  }
}
