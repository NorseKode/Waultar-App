// ignore_for_file: avoid_print
import 'package:waultar/core/inodes/profile_document.dart';

abstract class IParserService {
  // gets called by the uploader --> returns the paths
  // parse said files --> the two parsers
  // save parsed objects --> repositories
  //
  // on error throw exception
  Future<void> parseIsolates(String zipPath, Function(String message, bool isDone) callback, String serviceName, {ProfileDocument? profile});
  Future<void> parseMain(String zipPath, String serviceName);
}