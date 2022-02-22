import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as dart_path;
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

  static Future<List<String>> extractZip(String path) async {
    // using inputFileStream to access zip without storing it in memory
    final inputStream = InputFileStream(path);

    // decode the zip via the stream - the archive will have the contents of the zip
    // without having to store it in memory
    final archive = ZipDecoder().decodeBuffer(inputStream);
    String tempDestDirPath = locator.get<String>(instanceName: 'extracts_folder') + "/";
    final destDirPath = dart_path.normalize(tempDestDirPath);

    // TODO : easiest method, but this way we won't preserve the original paths 
    // extractArchiveToDisk(archive, destDirPath);

    var list = <String>[];
    for (var file in archive.files) {
      // only take the files and not the directories
      if (file.isFile) {
        var filePath = dart_path.normalize(destDirPath + '/' + file.name);
        // final outputStream = OutputFileStream(filePath);
        final f = File(filePath);
        f.parent.createSync(recursive: true);
        f.writeAsBytesSync(file.content as List<int>);
        list.add(f.path);
        // file.writeContent(outputStream);
      }
    }

    // final bytes = await File(path).readAsBytes();
    // final archive = ZipDecoder().decodeBytes(bytes);
    
    // for (final file in archive) {
    //   final filename = file.name;
    //   if (file.isFile) {
    //     final data = file.content as List<int>;
    //     var path = dart_path
    //         .normalize(locator.get<String>(instanceName: 'extracts_folder') + "/" + filename);
    //     var finalFile = File(path)
    //       ..createSync(recursive: true)
    //       ..writeAsBytesSync(data);
    //     list.add(finalFile.path);
    //   }
    // }

    return list;
  }

}
