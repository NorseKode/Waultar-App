import 'dart:io';

Future<List<String>> getAllFilesFrom(String path) async {
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