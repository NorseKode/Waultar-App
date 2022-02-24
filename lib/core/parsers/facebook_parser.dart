import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/startup.dart';

import 'dart:io';

import '../../configs/exceptions/parse_exception.dart';
import '../abstracts/abstract_parsers/base_parser.dart';
import 'package:path/path.dart' as path_dart;

class FacebookParser extends BaseParser {
  final _appLogger = locator.get<AppLogger>(instanceName: 'logger');
  static const _profileFiles = ["profile_information"];

  @override
  Stream<dynamic> parseFile(File file, {ProfileModel? profile}) async* {
    try {
      var jsonData = await ParseHelper.getJsonStringFromFile(file);
      var filename = path_dart.basenameWithoutExtension(file.path);
      const mediaKeys = ["uri", "content", "link"];
      var uriAlreadyUsed = [];
      var postFilenameRegex = RegExp(r"your_posts_\d+");

      var isPosts = false;
      var matchedFile = postFilenameRegex.firstMatch(filename);
      if (matchedFile != null) {
        isPosts = true;
      }

      if (isPosts) {
        for (var post in jsonData) {
          var postModel =
              PostModel.fromJson(post, profile ?? ParseHelper.profile);
          _appLogger.logger
              .info("Parsed Facebook profile: ${postModel.toString()}");
          yield postModel;
        }
      }

      await for (final object in ParseHelper.returnEveryJsonObject(jsonData)) {
        if (object is Map<String, dynamic>) {
          if (isPosts) {
            // skip
          } else if (object.containsKey("profile_v2") && profile == null) {
            var profileModel = ProfileModel.fromFacebook(object["profile_v2"]);
            _appLogger.logger
                .info("Parsed Facebook Profile: ${profileModel.toString()}");
            yield profileModel;
          } else if (object.containsKey("profile_v2") && profile != null) {
            var groupObjects = object["profile_v2"]["groups"];
            if (groupObjects is List<dynamic>) {
              for (var group in groupObjects) {
                var groupModel = GroupModel.fromJson(group, profile);
                _appLogger.logger
                    .info("Parsed Facebook group: ${groupModel.toString()}");
                yield groupModel;
              }
            }
          } else if (object.containsKey("groups_admined_v2")) {
            var groupsAdminedObjects = object['groups_admined_v2'];
            if (groupsAdminedObjects is List<dynamic>) {
              for (var group in groupsAdminedObjects) {
                var groupModel = GroupModel.fromJson(group, profile!);
                groupModel.isUsers = true;
                yield groupModel;
              }
            }
          } else if (object.containsKey('group_badges_v2')) {
            var badges = object['group_badges_v2'];
            if (badges is Map<String, dynamic>) {
              var entries = badges.entries;
              for (var item in entries) {
                var name = item.key;
                var badge = item.value[0];
                var model = GroupModel(
                  profile: profile!,
                  raw: item.toString(),
                  name: name,
                  badge: badge,
                  isUsers: true,
                );
                _appLogger.logger.info(
                    'Parsed badge to group ${model.name} : ${model.toString()}');

                yield model;
              }
            }
          } else {
            var mediaKey = object.keys
                .firstWhere((key) => mediaKeys.contains(key), orElse: () => "");

            if (mediaKey != "" && !uriAlreadyUsed.contains(object[mediaKey])) {
              switch (Extensions.getFileType(object[mediaKey])) {
                case FileType.image:
                  uriAlreadyUsed.add(object[mediaKey]);
                  var imageModel = ImageModel.fromJson(
                      object, profile ?? ParseHelper.profile);
                  _appLogger.logger
                      .info("Parsed Facebook image: ${imageModel.toString()}");
                  yield imageModel;
                  break;
                case FileType.video:
                  uriAlreadyUsed.add(object[mediaKey]);
                  var videoModel =
                      VideoModel.fromJson(object, ParseHelper.profile);
                  _appLogger.logger
                      .info("Parsed Facebook : ${videoModel.toString()}");
                  yield videoModel;
                  break;
                case FileType.file:
                  uriAlreadyUsed.add(object[mediaKey]);
                  var fileModel =
                      FileModel.fromJson(object, ParseHelper.profile);
                  _appLogger.logger
                      .info("Parsed Facebook : ${fileModel.toString()}");
                  yield fileModel;
                  break;
                case FileType.link:
                  if (object[mediaKey] is String &&
                      !object[mediaKey].startsWith("https://interncache")) {
                    uriAlreadyUsed.add(object[mediaKey]);
                    var linkModel =
                        LinkModel.fromJson(object, ParseHelper.profile);
                    _appLogger.logger
                        .info("Parsed Facebook : ${linkModel.toString()}");
                    yield linkModel;
                  }
                  break;
                default:
                  break;
              }
            }
          }
        }
      }
    } on Tuple2<String, dynamic> catch (e) {
      throw ParseException(
          "Unexpected error occured in parsing of file", file, e.item2);
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
      throw ParseException(
          "Unexpected error occured in parsing of file", file, e.item2);
    } on FormatException catch (e) {
      throw ParseException("Wrong formatted json", file, e);
    }
  }

  @override
  Future<Tuple2<ProfileModel, List<String>>> parseProfile(List<String> paths,
      {ServiceModel? service}) async {
    var profilePath =
        paths.firstWhere((element) => element.contains(_profileFiles[0]));
    // The file ins't removed as it still contains the list of groups which hasn't been parsed yet

    ProfileModel profile = await parseFile(File(profilePath))
        .where((event) => event is ProfileModel)
        .first;

    if (service != null) {
      profile.service = service;
    }

    return Tuple2(profile, paths);
  }

  @override
  Future<Tuple2<List<GroupModel>, List<String>>> parseGroupNames(
      List<String> paths, ProfileModel profile) async {
    var profilePath =
        paths.firstWhere((element) => element.contains(_profileFiles[0]));

    var groups = await parseFile(File(profilePath), profile: profile)
        .where((event) => event is GroupModel)
        .cast<GroupModel>()
        .toList();
    if (groups.isEmpty) {
      _appLogger.logger.info(
          'While parsing group names in file $profilePath no groups were found');
    }

    paths.remove(profilePath);
    return Tuple2(groups, paths);
  }

  @override
  Stream parseListOfPaths(List<String> paths, {ProfileModel? profile}) async* {
    for (var path in paths) {
      if (Extensions.isJson(path)) {
        var file = File(path);
        await for (final result
            in parseFile(file, profile: profile ?? ParseHelper.profile)) {
          yield result;
        }
      }
    }
  }

  @override
  Stream<dynamic> parseDirectory(Directory directory) {
    // TODO: implement parseDirectory
    throw UnimplementedError();
  }
}
