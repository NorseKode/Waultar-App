import 'package:waultar/core/models/index.dart';

abstract class IParserService {
  // gets called by the uploader --> returns the paths
  // parse said files --> the two parsers
  // save parsed objects --> repositories
  //
  // on error throw exception
  void parseAll(Map<String, String> inputMap);
}
