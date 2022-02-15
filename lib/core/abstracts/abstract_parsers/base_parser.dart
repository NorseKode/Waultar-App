import 'dart:io';

import 'package:waultar/core/models/base_model.dart';

abstract class BaseParser {
  /// Parses all files in [directory]
  ///
  /// Takes a directory [directory] and reads all files in said directory.
  /// Followed by an parsing of every file in said directory
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  Stream<BaseModel> parseDirectory(Directory directory);
  /// Parses a single [file]
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  Stream<dynamic> parseFile(File file);
}

enum DataTypes {
  unknown,
  post,
  media
}
