// ignore_for_file: unused_field

import 'dart:convert';

import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/core/helpers/performance_helper2.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/core/parsers/tree_parser.dart';
import 'package:waultar/domain/workers/parser_worker.dart';
import 'package:waultar/domain/workers/unzip_worker.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';
import 'package:waultar/startup.dart';

class ParserService implements IParserService {
  var _totalCount = 0;
  var _pathsToParse = <String>[];

  final String _waultarPath = locator.get<String>(instanceName: 'waultar_root_directory');
  final BaseLogger _logger = locator.get<BaseLogger>(instanceName: 'logger');
  final ProfileRepository _profileRepo =
      locator.get<ProfileRepository>(instanceName: 'profileRepo');
  final IServiceRepository _serviceRepo =
      locator.get<IServiceRepository>(instanceName: 'serviceRepo');
  ParserService();
  final _performance = locator.get<PerformanceHelper2>(instanceName: 'performance2');

  @override
  Future<void> parseIsolates(
    String zipPath,
    Function(String message, bool isDone) callback,
    String serviceName,
    ProfileDocument profile,
    ) async {
    if (ISPERFORMANCETRACKING) {
      var key = "Extracting and parsing synchronously";
      _performance.reInit(newParentKey: key);
      _performance.start(key);
    }

    var service = _serviceRepo.get(serviceName)!;
    profile.service.target = service;
    profile = _profileRepo.add(profile);

    _startExtracting(zipPath, callback, profile);
  }

  _startExtracting(String zipPath, Function callback, ProfileDocument profile) {
    if (ISPERFORMANCETRACKING) {
      var key = "Extracting files";
      _performance.startReading(key);
    }

    var initiator = IsolateUnzipStartPackage(
      pathToZip: zipPath,
      isPerformanceTracking: ISPERFORMANCETRACKING,
      profileName: profile.name,
      waultarPath: _waultarPath,
    );
    _listenZip(dynamic data) {
      switch (data.runtimeType) {
        case MainUnzipTotalCountPackage:
          data as MainUnzipTotalCountPackage;
          _totalCount = data.total;
          callback("Total files to extract: $_totalCount", false);
          if (ISPERFORMANCETRACKING) {
            _performance.addReading(_performance.parentKey, "Extracting files");
          }
          break;

        case MainUnzipProgressPackage:
          data as MainUnzipProgressPackage;
          callback("${data.progress} files extracted out of $_totalCount", false);
          if (ISPERFORMANCETRACKING) {
            var performanceNode = PerformanceDataPoint.fromMap(jsonDecode(data.performanceNode));
            _performance.addReading(
              "Extracting files",
              performanceNode.key,
              data: performanceNode,
            );
          }
          break;

        case MainUnzippedPathsPackage:
          data as MainUnzippedPathsPackage;
          _pathsToParse = data.pathsInSameFolder;
          _startParsing(callback, profile);
          break;
        default:
      }
    }

    var zipWorker = BaseWorker(initiator: initiator, mainHandler: _listenZip);
    zipWorker.init(unzipWorkerBody);
  }

  _startParsing(Function callback, ProfileDocument profile) {
    if (ISPERFORMANCETRACKING) {
      _performance.startReading("Parsing of files");
    }

    var parseInitiator = IsolateParserStartPackage(
      paths: _pathsToParse,
      profileId: profile.id,
      isPerformanceTracking: ISPERFORMANCETRACKING,
      waultarPath: _waultarPath,
    );
    _listenParser(dynamic data) {
      switch (data.runtimeType) {
        case MainParsedProgressPackage:
          data as MainParsedProgressPackage;
          callback("Parsing ${data.parsedCount}/${_pathsToParse.length}", data.isDone);

          if (data.isDone && ISPERFORMANCETRACKING) {
            _performance.addReading(_performance.parentKey, "Parsing of files", childs: _performance.getStoredDataPoints());
            _performance.addParentReading();
            _performance.summary("Parsing and Extracting Synchronously");
          } else if (ISPERFORMANCETRACKING) {
            var performanceNode = PerformanceDataPoint.fromMap(jsonDecode(data.performanceDataPoint));
            _performance.storeDataPoint(performanceNode);
          }
          break;

        case MainErrorPackage:
          data as MainErrorPackage;
          callback(data.message, true);
          break;
        default:
      }
    }

    var parseWorker = BaseWorker(mainHandler: _listenParser, initiator: parseInitiator);
    parseWorker.init(parseWorkerBody);
  }

  // we could use this for performance checking of isolates vs single
  @override
  Future<void> parseMain(String zipPath, String serviceName) async {
    var profile = ProfileDocument(name: "temp test name");
    var service = _serviceRepo.get(serviceName)!;
    profile.service.target = service;
    profile = _profileRepo.add(profile);

    var files = await FileUploader.extractZip(zipPath, serviceName, profile.name);
    await locator.get<TreeParser>(instanceName: 'parser').parseManyPaths(files, profile);
  }

  @override
  void dispose() {
  }
}
