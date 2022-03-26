// ignore_for_file: unused_field

import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/data/configs/objectbox.dart';

class ParserService implements IParserService {
  
  
  final ObjectBox _context;
  final AppLogger _logger;
  ParserService(
    this._context,
    this._logger,
  );
  // receive list of paths
  // løbe gennem alle .json filer
  // spawn en ny isolate der udfører den statiske parser
  // (skal være statisk pga isolates)
  @override
  void parse(List<String> paths, ProfileDocument profile) {
    // TODO: implement parse
  }
}
