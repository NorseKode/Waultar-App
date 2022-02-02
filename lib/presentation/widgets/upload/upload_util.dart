import 'dart:io';

Future<List<File>> getAllFilesFrom(String path) async {
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