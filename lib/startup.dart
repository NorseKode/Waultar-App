import 'dart:io';
import 'dart:ffi';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:sqlite3/open.dart';
import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_image_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/domain/services/appsettings_service.dart';
import 'configs/globals/os_enum.dart';
import 'package:path/path.dart' as dart_path;

final locator = GetIt.instance;
late OS os;

Future<void> setupServices({bool testing = false}) async {
  os = detectPlatform();
  locator.registerSingleton<OS>(os, instanceName: 'platform');

  // configure on startup the correct sqlite binary to use
  configureSQLiteBinaries();

  // when correct sqlite binary have initialized, register the db
  testing
      ? locator.registerSingleton<WaultarDb>(
          WaultarDb.testing(NativeDatabase.memory()))
      : locator.registerSingleton<WaultarDb>(WaultarDb());

  var db = locator<WaultarDb>();

  locator.registerSingleton<IAppSettingsRepository>(db.appSettingsDao,
      instanceName: 'appSettingsDao');
  locator.registerSingleton<IImageRepository>(db.imageDao,
      instanceName: 'imageDao');
  locator.registerSingleton<IProfileRepository>(db.profileDao,
      instanceName: 'profileDao');

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

void configureSQLiteBinaries() {
  switch (locator<OS>(instanceName: 'platform')) {
    
    case OS.windows:
      open.overrideFor(OperatingSystem.windows, _openOnWindows);
      break;

    case OS.linux:
      open.overrideFor(OperatingSystem.linux, _openOnLinux);
      break;
      
    default:
  }
}

DynamicLibrary _openOnWindows() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript =
      File(dart_path.normalize('${scriptDir.path}/lib/assets/sqlite/sqlite3.dll'));
  return DynamicLibrary.open(libraryNextToScript.path);
}

// TODO : place sqlite.so file in assets
// should be the same as for windows but with a sqlite3.so binary instead
// just place the .so file in assets next to the .dll
DynamicLibrary _openOnLinux() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript =
      File('${scriptDir.path}/lib/assets/sqlite/sqlite3.so');
  return DynamicLibrary.open(libraryNextToScript.path);
}
