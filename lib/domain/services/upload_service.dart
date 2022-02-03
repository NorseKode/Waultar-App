import 'dart:io';
import 'package:archive/archive.dart';

class UploadService {
  Archive extractZip(String path) {
    final bytes = File(path).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      print(file.name);
    }

    return archive;
  }
}