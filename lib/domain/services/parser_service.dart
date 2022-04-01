// ignore_for_file: unused_field

import 'dart:convert';

import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_buckets_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/core/helpers/performance_helper.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/core/parsers/tree_parser.dart';
import 'package:waultar/domain/workers/parser_worker.dart';
import 'package:waultar/domain/workers/shared_packages.dart';
import 'package:waultar/domain/workers/unzip_worker.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';
import 'package:waultar/startup.dart';

class ParserService implements IParserService {
  var _totalCount = 0;
  var _pathsToParse = <String>[];
  late final DateTime _parsingStartedAt;

  final String _waultarPath = locator.get<String>(
    instanceName: 'waultar_root_directory',
  );
  final BaseLogger _logger = locator.get<BaseLogger>(
    instanceName: 'logger',
  );
  final ProfileRepository _profileRepo = locator.get<ProfileRepository>(
    instanceName: 'profileRepo',
  );
  final IServiceRepository _serviceRepo = locator.get<IServiceRepository>(
    instanceName: 'serviceRepo',
  );
  final IBucketsRepository _bucketsRepo = locator.get<IBucketsRepository>(instanceName: 'bucketsRepo',);
  ParserService();
  final _performance = locator.get<PerformanceHelper>(
    instanceName: 'performance',
  );

  @override
  Future<void> parseIsolates(
    String zipPath,
    Function(String message, bool isDone) callback,
    String serviceName,
    ProfileDocument profile,
  ) async {
    if (ISPERFORMANCETRACKING) {
      _performance.init(newParentKey: "Extracting and parsing synchronously");
      _performance.startReading(_performance.parentKey);
    }

    _parsingStartedAt = DateTime.now();

    var service = _serviceRepo.get(serviceName)!;
    profile.service.target = service;
    profile = _profileRepo.add(profile);

    _startExtracting(zipPath, callback, profile);
  }

  _startExtracting(String zipPath, Function callback, ProfileDocument profile) {
    var initiator = IsolateUnzipStartPackage(
      pathToZip: zipPath,
      isPerformanceTracking: ISTRACKALL,
      profileName: profile.name,
      waultarPath: _waultarPath,
    );
    _listenZip(dynamic data) {
      switch (data.runtimeType) {
        case MainUnzipTotalCountPackage:
          data as MainUnzipTotalCountPackage;
          _totalCount = data.total;
          callback("Total files to extract: $_totalCount", false);
          break;

        case MainUnzipProgressPackage:
          data as MainUnzipProgressPackage;
          callback(
              "${data.progress} files extracted out of $_totalCount", false);
          break;

        case MainUnzippedPathsPackage:
          data as MainUnzippedPathsPackage;
          _pathsToParse = data.pathsInSameFolder;
          _startParsing(callback, profile);

          if (ISPERFORMANCETRACKING && ISTRACKALL) {
            _performance.addDataPoint(
                _performance.parentKey,
                PerformanceDataPoint.fromMap(
                    jsonDecode(data.performanceDataPoint)));
          }

          break;

        case MainPerformanceMeasurementPackage:
          data as MainPerformanceMeasurementPackage;
          if (ISPERFORMANCETRACKING && ISTRACKALL) {
            var performanceReading = PerformanceDataPoint.fromMap(
                jsonDecode(data.performanceDataPointJson));
            _performance.storeDataPoint("Extracting files", performanceReading);
          }
          break;
        default:
      }
    }

    var zipWorker = BaseWorker(initiator: initiator, mainHandler: _listenZip);
    zipWorker.init(unzipWorkerBody);
  }

  _startParsing(Function callback, ProfileDocument profile) {
    var parseInitiator = IsolateParserStartPackage(
      paths: _pathsToParse,
      profileId: profile.id,
      isPerformanceTracking: ISTRACKALL,
      waultarPath: _waultarPath,
    );
    _listenParser(dynamic data) {
      switch (data.runtimeType) {
        case MainParsedProgressPackage:
          data as MainParsedProgressPackage;
          callback("Parsing ${data.parsedCount}/${_pathsToParse.length}",
              data.isDone);

          if (data.isDone) {
            _bucketsRepo.createBuckets(_parsingStartedAt);
          }

          if (data.isDone && ISPERFORMANCETRACKING && ISTRACKALL) {
            _performance.addData(_performance.parentKey,
                duration: _performance.stopReading(_performance.parentKey));
            _performance.addDataPoint(
                _performance.parentKey,
                PerformanceDataPoint.fromMap(
                    jsonDecode(data.performanceDataPoint)));
            _performance.summary("Extraction and parsing");
          }
          break;

        case MainErrorPackage:
          data as MainErrorPackage;
          callback(data.message, true);
          break;
        default:
      }
    }

    var parseWorker =
        BaseWorker(mainHandler: _listenParser, initiator: parseInitiator);
    parseWorker.init(parseWorkerBody);
  }

  // we could use this for performance checking of isolates vs single
  @override
  Future<void> parseMain(String zipPath, String serviceName) async {
    var profile = ProfileDocument(name: "temp test name");
    var service = _serviceRepo.get(serviceName)!;
    profile.service.target = service;
    profile = _profileRepo.add(profile);

    var files = FileUploader.extractZip(zipPath, serviceName, profile.name);
    locator
        .get<TreeParser>(instanceName: 'parser')
        .parseManyPaths(files, profile);
  }

  @override
  void dispose() {}
}
