import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/repositories/appsettings_repo.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/model_builders/model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/objectbox_director.dart';
import 'package:waultar/data/repositories/post_repo.dart';
import 'package:waultar/domain/services/appsettings_service.dart';
import 'configs/globals/os_enum.dart';

final locator = GetIt.instance;
late final OS os;
late final ObjectBox _context;
late final IObjectBoxDirector _objectboxDirector;
late final IModelDirector _modelDirector;

Future<void> setupServices() async {
  os = detectPlatform();
  locator.registerSingleton<OS>(os, instanceName: 'platform');

  // create objectbox at startup
  // this MUST be the only context throughout runtime
  _context = await ObjectBox.create();
  locator.registerSingleton<ObjectBox>(_context, instanceName: 'context');

  // inject context to objectboxDirector, to access the store and boxes
  // the director is used to map from models to entities in repositories
  _objectboxDirector = ObjectBoxDirector(_context);
  locator.registerSingleton<IObjectBoxDirector>(_objectboxDirector,
      instanceName: 'objectbox_director');

  // model director is the opposite of ObjectBoxDirector
  // this director maps from entity to model
  _modelDirector = ModelDirector();
  locator.registerSingleton<IModelDirector>(_modelDirector,
      instanceName: 'model_director');

  // register all abstract repositores with their conrete implementations
  // each repo gets injected the context (to access the relevant store)
  // and the objectboxDirector to map from models to entities
  locator.registerSingleton<IAppSettingsRepository>(
      AppSettingsRepository(_context),
      instanceName: 'appSettingsRepo');
  locator.registerSingleton<IPostRepository>(
      PostRepository(_context, _objectboxDirector, _modelDirector),
      instanceName: 'postRepo');

  // register all services and inject their dependencies
  locator.registerSingleton<IAppSettingsService>(AppSettingsService(),
      instanceName: 'appSettingsService');
}

OS detectPlatform() {
  if (Platform.isWindows) {
    return OS.windows;
  }

  if (Platform.isLinux) {
    return OS.linux;
  }

  if (Platform.isMacOS) {
    return OS.macos;
  }

  if (Platform.isAndroid) {
    return OS.android;
  }

  if (Platform.isIOS) {
    return OS.ios;
  }

  if (kIsWeb) {
    return OS.web;
  }

  throw Exception('Could not detect platform');
}

// DynamicLibrary _openOnWindows() {
//   final scriptDir = File(Platform.script.toFilePath()).parent;
//   final libraryNextToScript = File(
//       dart_path.normalize('${scriptDir.path}/lib/assets/sqlite/sqlite3.dll'));
//   return DynamicLibrary.open(libraryNextToScript.path);
// }

// DynamicLibrary _openOnLinux() {
//   final scriptDir = File(Platform.script.toFilePath()).parent;
//   final libraryNextToScript =
//       File('${scriptDir.path}/lib/assets/sqlite/sqlite3.so');
//   return DynamicLibrary.open(libraryNextToScript.path);
// }
