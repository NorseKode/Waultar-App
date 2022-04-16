import 'dart:convert';
import 'dart:isolate';

import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/base_worker/package_models.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/core/parsers/tree_parser.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/domain/workers/shared_packages.dart';
import 'package:waultar/startup.dart';

  TreeParser? parser;
  ProfileDocument? profile;
Future parseWorkerBody2(dynamic data, SendPort mainSendPort, Function onError) async {
  bool isPerformance = false;
  var pathsToBeParsed = <String>[];

  switch (data.runtimeType) {
    case IsolateParserStartPackage:
      await setupIsolate(mainSendPort, data, data.waultarPath);
      data as IsolateParserStartPackage;
      profile = locator.get<ProfileRepository>(instanceName: 'profileRepo').get(data.profileId);
      isPerformance = data.isPerformanceTracking;
      parser = locator.get<TreeParser>(instanceName: 'parser');

      mainSendPort.send(MainParseSetupDonePackage());
      break;

    case IsolateParseDestDirPackage:
      data as IsolateParseDestDirPackage;
      parser!.basePathToFiles = data.destDir;
      break;

    case IsolateParserClosePackage:
      data as IsolateParserClosePackage;
      var _context = locator.get<ObjectBox>(instanceName: 'context');
      _context.store.close();
      break;

    case IsolateParseFilePackage:
      try {
        data as IsolateParseFilePackage;
        var count = 0;
        await for (final _ in parser!.parseManyPaths(data.pathToFile, profile!)) {
          count++;
        }
        mainSendPort.send(
            MainParsedProgressPackage(parsedCount: count, isDone: false, performanceDataPoint: ""));
      } catch (e, stackTrace) {
        mainSendPort.send(LogRecordPackage(e.toString(), stackTrace.toString()));
      }
      break;
  }

  // if (data is IsolateParserStartPackage) {
  //   try {
  //     await setupIsolate(mainSendPort, data, data.waultarPath);
  //     var count = 0;
  //     var profile = locator.get<ProfileRepository>(instanceName: 'profileRepo').get(data.profileId);
  //     var performance = locator<PerformanceHelper>(instanceName: "performance");

  //     if (data.isPerformanceTracking) {
  //       ISPERFORMANCETRACKING = true;
  //       performance.init(newParentKey: "Parsing of files");
  //       performance.startReading(performance.parentKey);
  //     }

  //     if (profile == null) {
  //       mainSendPort.send("No profile with id: ${data.profileId}");
  //     } else {
  //       var parser = locator.get<TreeParser>(instanceName: 'parser');

  //       if (data.isPerformanceTracking) {
  //         performance.startReading("Parse of file");
  //       }
  //       await for (final increment in parser.parseManyPaths(data.paths, profile)) {
  //         if (data.isPerformanceTracking) {
  //           var key = "Parse of file";
  //           performance.addReading(
  //             performance.parentKey,
  //             key,
  //             performance.stopReading(key),
  //             metadata: {"file name": data.paths[count]},
  //           );
  //           count++;
  //         }
  //         mainSendPort.send(MainParsedProgressPackage(
  //           parsedCount: increment,
  //           isDone: false,
  //           performanceDataPoint: "",
  //         ));
  //       }

  //       if (data.isPerformanceTracking) {
  //         performance.addData(performance.parentKey,
  //             duration: performance.stopReading(performance.parentKey));
  //       }

  //       mainSendPort.send(MainParsedProgressPackage(
  //         parsedCount: 0,
  //         isDone: true,
  //         performanceDataPoint:
  //             data.isPerformanceTracking ? jsonEncode(performance.parentDataPoint.toMap()) : "",
  //       ));
  //     }
  //   } catch (e, stackTrace) {
  //     mainSendPort.send(LogRecordPackage(e.toString(), stackTrace.toString()));
  //   } finally {
  //     var _context = locator.get<ObjectBox>(instanceName: 'context');
  //     _context.store.close();
  //   }
  // }
}

// run setupServices with configuration
// this call enables you to use all normal dependencies, the logger and objectbox
// - it abstracts away that the code being executed is in its own memory space
Future<void> setupIsolate(SendPort sendPort, InitiatorPackage setupData, String waultarPath) async {
  await setupServices(
      testing: setupData.testing, isolate: true, sendPort: sendPort, waultarPath: waultarPath);
}

class IsolateParserStartPackage extends InitiatorPackage {
  List<String> paths;
  int profileId;
  bool isPerformanceTracking;
  String waultarPath;

  IsolateParserStartPackage({
    required this.paths,
    required this.profileId,
    required this.isPerformanceTracking,
    required this.waultarPath,
  });
}

class IsolateParseFilePackage {
  List<String> pathToFile;

  IsolateParseFilePackage({required this.pathToFile});
}

class IsolateParserClosePackage {}

class IsolateParseDestDirPackage {
  String destDir;

  IsolateParseDestDirPackage({required this.destDir});
}
class MainParsedProgressPackage {
  int parsedCount;
  bool isDone;
  String performanceDataPoint;

  MainParsedProgressPackage({
    required this.parsedCount,
    required this.isDone,
    required this.performanceDataPoint,
  });
}

class MainParseSetupDonePackage {}

class MainErrorPackage {
  String message;

  MainErrorPackage({required this.message});
}
