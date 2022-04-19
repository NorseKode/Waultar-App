import 'dart:isolate';

import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/core/parsers/tree_parser.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/startup.dart';

  TreeParser? parser;
  ProfileDocument? profile;
Future parseWorkerBody2(dynamic data, SendPort mainSendPort, Function onError) async {
  bool isPerformance = false;
  var pathsToBeParsed = <String>[];

  switch (data.runtimeType) {
    case IsolateParserParaStartPackage:
      await setupIsolate(mainSendPort, data, data.waultarPath);
      data as IsolateParserParaStartPackage;
      profile = locator.get<ProfileRepository>(instanceName: 'profileRepo').get(data.profileId);
      isPerformance = data.isPerformanceTracking;
      parser = locator.get<TreeParser>(instanceName: 'parser');

      break;

    case IsolateParseParaDestDirPackage:
      data as IsolateParseParaDestDirPackage;
      parser!.basePathToFiles = data.destDir;
      break;

    case IsolateParserParaClosePackage:
      data as IsolateParserParaClosePackage;
      var _context = locator.get<ObjectBox>(instanceName: 'context');
      _context.store.close();
      break;

    case IsolateParseParaFilePackage:
      try {
        data as IsolateParseParaFilePackage;
        var count = 0;
        await for (final _ in parser!.parseManyPaths(data.pathToFile, profile!)) {
          count++;
        }
        mainSendPort.send(
            MainParsedParaProgressPackage(parsedCount: count, isDone: false, performanceDataPoint: ""));
      } catch (e, stackTrace) {
        mainSendPort.send(LogRecordPackage(e.toString(), stackTrace.toString()));
      }
      break;
  }
}

// run setupServices with configuration
// this call enables you to use all normal dependencies, the logger and objectbox
// - it abstracts away that the code being executed is in its own memory space
Future<void> setupIsolate(SendPort sendPort, InitiatorPackage setupData, String waultarPath) async {
  await setupServices(
      testing: setupData.testing, isolate: true, sendPort: sendPort, waultarPath: waultarPath);
}

class IsolateParserParaStartPackage extends InitiatorPackage {
  List<String> paths;
  int profileId;
  bool isPerformanceTracking;
  String waultarPath;

  IsolateParserParaStartPackage({
    required this.paths,
    required this.profileId,
    required this.isPerformanceTracking,
    required this.waultarPath,
  });
}

class IsolateParseParaFilePackage {
  List<String> pathToFile;

  IsolateParseParaFilePackage({required this.pathToFile});
}

class IsolateParserParaClosePackage {}

class IsolateParseParaDestDirPackage {
  String destDir;

  IsolateParseParaDestDirPackage({required this.destDir});
}
class MainParsedParaProgressPackage {
  int parsedCount;
  bool isDone;
  String performanceDataPoint;

  MainParsedParaProgressPackage({
    required this.parsedCount,
    required this.isDone,
    required this.performanceDataPoint,
  });
}

class MainParaErrorPackage {
  String message;

  MainParaErrorPackage({required this.message});
}
