import 'dart:io';

abstract class BaseParser {
  Stream<dynamic> parseListOfPaths(List<String> paths);

  /// Parses all files in [directory]
  ///
  /// Takes a directory [directory] and reads all files in said directory.
  /// Followed by an parsing of every file in said directory
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  Stream<dynamic> parseDirectory(Directory directory);

  /// Parses a single [file]
  ///
  /// Throws an [ParseException] if something unexpected in encountered
  Stream<dynamic> parseFile(File file);
}

enum DataTypes { unknown, post, media }
