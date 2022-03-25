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
  final appLogger = locator.get<AppLogger>(instanceName: 'logger');
  static const _profileFiles = ["personal_information", "signup_information"];
  // final _imageClassifier = locator.get<ImageClassifier>(instanceName: 'imageClassifier');
  // final _profileRepo = locator.get<IProfileRepository>(instanceName: 'profileRepo');

  @override
  Stream<dynamic> parseFile(File file, {ProfileModel? profile}) async* {
    try {
      var jsonData = await ParseHelper.getJsonStringFromFile(file);

      await for (final object in ParseHelper.returnEveryJsonObject(jsonData)) {
        if (object is Map<String, dynamic>) {
          if (object.containsKey("profile_user")) {
            var result = ProfileModel.fromInstragram(object["profile_user"].first);
            appLogger.logger.info("Parsed Instagram Profile: ${result.toString()}");
            yield result;
          } else if (object.containsKey("media")) {
            var result = PostModel.fromInstagram(object, profile ?? ParseHelper.profile);
            appLogger.logger.info("Parsed Instagram Post: ${result.toString()}");
            yield result;
          } else if (object.containsKey("comments_media_comments")) {
            for (var comment in object["comments_media_comments"]) {
              var commentModel = CommentModel.fromInstagram(comment, profile!);
              appLogger.logger.info("Parsed Instagram Comment: ${comment.toString()}");
              yield commentModel;
            }
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
  Future<Tuple2<ProfileModel, List<String>>> parseProfile(List<String> paths,
      {ServiceModel? service}) async {
    // _imageClassifier.init();

    var profileMain = paths.firstWhere((element) => element.contains(_profileFiles[0]));
    paths.remove(profileMain);

    ProfileModel profile =
        await parseFile(File(profileMain)).where((event) => event is ProfileModel).first;

    if (paths.length > 1) {
      var basePathToFiles = StringBuffer();
      var path1 = paths.first;
      var path2 = paths.last;

      for (var i = 0; i < path1.length; i++) {
        if (path1[i] == path2[i]) {
          basePathToFiles.write(path1[i]);
        } else {
          break;
        }
      }

      profile.basePathToFiles = basePathToFiles.toString();
    }

    if (service != null) {
      profile.service = service;
    }

    var profileCreationDate = paths.firstWhere((element) => element.contains(_profileFiles[1]));
    paths.remove(profileCreationDate);

    await parseFileLookForKey(File(profileCreationDate), "Time").first.then((value) =>
        profile.createdTimestamp =
            ModelHelper.getTimestamp(value) ?? DateTime.fromMicrosecondsSinceEpoch(0));

    // _imageClassifier.dispose();

    return Tuple2(profile, paths);
  }

  @override
  Stream parseListOfPaths(List<String> paths, ProfileModel profile) async* {
    // await _imageClassifier.init();

    for (var path in paths) {
      if (Extensions.isJson(path)) {
        var file = File(path);
        await for (final result in parseFile(file, profile: profile)) {
          yield result;
        }
      }
    }

    // _imageClassifier.dispose();
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

  @override
  Future<Tuple2<List<GroupModel>, List<String>>> parseGroupNames(
      List<String> paths, ProfileModel profile) {
    throw UnimplementedError();
  }
}
