import 'dart:io';

class ParseException implements Exception {
  final String message;
  final File file;
  final dynamic object;

  ParseException(this.message, this.file, this.object);
}