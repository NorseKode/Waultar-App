import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:waultar/configs/exceptions/parse_exception.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/abstracts/abstract_parsers/base_parser.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/presentation/widgets/upload/upload_util.dart';
import 'package:waultar/startup.dart';

class InstagramParser extends BaseParser {
  var appLogger = locator.get<AppLogger>(instanceName: 'logger');
  static const _profileFiles = ["personal_information", "signup_information"];

  
  @override
  Stream<dynamic> parseFile(File file, {ProfileModel? profile}) async* {
    try {
      var jsonData = await ParseHelper.getJsonStringFromFile(file);

      await for (final object in ParseHelper.returnEveryJsonObject(jsonData)) {
        if (object is Map<String, dynamic>) {
          if (object.containsKey("profile_user")) {
            var result = ProfileModel.fromInstragram(object["profile_user"].first);
            appLogger.logger.info("parsed object: ${result.toString()}");
            yield result;
          } else if (object.containsKey("media")) {
            var result = PostModel.fromJson(object, profile ?? ParseHelper.profile);
            appLogger.logger.info("parsed object: ${result.toString()}");
            yield result;
          } else {
            // appLogger.logger.info("unknown data: ${object.toString()}");
          }

          //   var dataMap = ParseHelper.jsonDataAsMap(object, "parentKey", [""]);

          //   switch (Extensions.getFileType(dataMap["uri"])) {
          //     case FileType.image:
          //       yield ImageModel.fromJson(dataMap, ParseHelper.profile);
          //       break;
          //     case FileType.video:
          //       yield VideoModel.fromJson(dataMap, ParseHelper.profile);
          //       break;
          //     default:
          //   }
        }
      }
    } on Tuple2<String, dynamic> catch (e) {
      throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
    } on FormatException catch (e) {
      throw ParseException("Wrong formatted json", file, e);
    }
  }

  @override
  Stream<dynamic> parseFileLookForKey(File file, String key) async* {
    try {
      var jsonData = await ParseHelper.getJsonStringFromFile(file);

      await for (final object in ParseHelper.returnEveryJsonObject(jsonData)) {
        if (object is Map<String, dynamic>) {
          if (object.containsKey(key)) {
            yield object[key];
          }
        }
      }
    } on Tuple2<String, dynamic> catch (e) {
      throw ParseException("Unexpected error occured in parsing of file", file, e.item2);
    } on FormatException catch (e) {
      throw ParseException("Wrong formatted json", file, e);
    }
  }

  @override
  Future<Tuple2<ProfileModel, List<String>>> parseProfile(List<String> paths, {ServiceModel? service}) async {
    var profileMain = paths.firstWhere((element) => element.contains(_profileFiles[0]));
    paths.remove(profileMain);

    ProfileModel profile =
        await parseFile(File(profileMain)).where((event) => event is ProfileModel).first;

    if (service != null) {
      profile.service = service;
    }

    var profileCreationDate = paths.firstWhere((element) => element.contains(_profileFiles[1]));
    paths.remove(profileCreationDate);

    await parseFileLookForKey(File(profileCreationDate), "Time")
        .first
        .then((value) => profile.createdTimestamp =
            ModelHelper.getTimestamp(value) ??
                DateTime.fromMicrosecondsSinceEpoch(0));

    return Tuple2(profile, paths);
  }

  @override
  Stream parseListOfPaths(List<String> paths, {ProfileModel? profile}) async* {
    for (var path in paths) {
      if (Extensions.isJson(path)) {
        var file = File(path);
        await for (final result in parseFile(file, profile: profile ?? ParseHelper.profile)) {
          yield result;
        }
      }
    }
  }

  @override
  Stream<dynamic> parseDirectory(Directory directory) async* {
    var files = await getAllFilesFrom(directory.path);

    for (var file in files) {
      if (Extensions.isJson(file.path)) {
        await for (final result in parseFile(file)) {
          yield result;
        }
      }
    }
  }

  
}
