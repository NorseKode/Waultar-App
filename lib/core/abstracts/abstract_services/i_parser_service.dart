// ignore_for_file: avoid_print

import 'dart:isolate';

import 'package:easy_isolate/easy_isolate.dart';
import 'package:waultar/core/inodes/profile_document.dart';

abstract class IParserService {
  // gets called by the uploader --> returns the paths
  // parse said files --> the two parsers
  // save parsed objects --> repositories
  //
  // on error throw exception
  void parse(List<String> paths, ProfileDocument profile);
}

abstract class IsolateWorker {
  void setup();
}

/* setup for isolates :
  1)  lav en setup metode der kan kaldes til at instantiere 
      de korrekt dependencies for den nye isolate

  - skal kunne sende logbeskeder til en sendport 
  - skal have en reference til en objectbox så den kan instantiere korrekte repos (parser)
  - 
*/

class TestIsolates {
  void main() async {
  }

  static void mainHandler(dynamic data, SendPort sendPort) {}
  
  static void isolateHandler(
    dynamic data,
    SendPort mainSendPort,
    SendErrorFunction sendError,
  ) 
  {
    if (data is String) {
      print(data);
    }
  }
}
