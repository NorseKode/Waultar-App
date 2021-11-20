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
}