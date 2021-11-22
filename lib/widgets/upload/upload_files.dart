import 'dart:io';

import 'package:file_picker/file_picker.dart';

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
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    
    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    } else {
      return null;
    }
  }
  
  /// Returns a list of files if users picks a directory, reutrns `null` otherwise
  static Future<List<File>?> uploadDirectory() async {
    String? path = await FilePicker.platform.getDirectoryPath();
    
    if (path != null) {
      return await _getAllFilesFrom(path);
    } else {
      return null;
    }
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
}