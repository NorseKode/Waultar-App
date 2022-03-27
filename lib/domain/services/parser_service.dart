// ignore_for_file: unused_field

import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/base_worker/base_worker.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/profile_repo.dart';
import 'package:waultar/core/inodes/tree_parser.dart';
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

  @override
  Future<void> parseIsolates(String zipPath, Function(String message, bool isDone) callback, String serviceName,
      {ProfileDocument? profile}) async {

    var profile = ProfileDocument(name: "temp test name");
    var service = _serviceRepo.get(serviceName)!;
    profile.service.target = service;
    profile = _profileRepo.add(profile);


    // unzip
    _listenZip(dynamic data) {
      switch (data.runtimeType) {
        case MainUnzipTotalCountPackage:
          data as MainUnzipTotalCountPackage;
          _totalCount = data.total;
          callback("Extracting files $_totalCount", false);
          break;

        case MainUnzippedPathsPackage:
          data as MainUnzippedPathsPackage;
          _pathsToParse = data.pathsInSameFolder;
          break;
        default:
      }
    }

    var initiator = IsolateUnzipStartPackage(
      pathToZip: zipPath,
      isPerformanceTracking: ISPERFORMANCETRACKING,
      profileName: profile.name,
      waultarPath: _waultarPath,
    );
    var zipWorker = BaseWorker(initiator: initiator, mainHandler: _listenZip);
    await zipWorker.init(unzipWorkerBody);

    // parse the unzipped dir
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
          break;

        case MainErrorPackage:
          data as MainErrorPackage;
          callback(data.message, true);
          break;
        default:
      }
    }

    var parseWorker = BaseWorker(mainHandler: _listenParser, initiator: parseInitiator);
    await parseWorker.init(parseWorkerBody);
  }

  @override
  Future<void> parseMain(String zipPath, String serviceName) async {
    var profile = ProfileDocument(name: "temp test name");
    var service = _serviceRepo.get(serviceName)!;
    profile.service.target = service;
    profile = _profileRepo.add(profile);
    
    var files = await FileUploader.extractZip(zipPath, serviceName, profile.name);
    await locator.get<TreeParser>(instanceName: 'parser').parseManyPaths(files, profile);
  }
}
