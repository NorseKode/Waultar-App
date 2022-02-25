import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/media_extensions.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/models/content/post_poll_model.dart';
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
          } else if (object.containsKey('groups_joined_v2')) {
            var groupObjects = object['groups_joined_v2'];
            if (groupObjects is List<dynamic>) {
              for (var group in groupObjects) {
                if (group.containsKey('data')) {
                  var data = group['data'] as List<dynamic>;
                  var name = data.first['name'];
                  group.putIfAbsent('name', () => name);
                  var model = GroupModel.fromJson(group, profile!);
                  yield model;
                }
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
          } else if (object.containsKey('your_events_v2')) {
            var yourEvents = object['your_events_v2'] as List<dynamic>;
            for (var event in yourEvents) {
              var model = EventModel.fromJson(event, profile!);
              model.isUsers = true;
              yield model;
            }
          } else if (object.containsKey('event_responses_v2')) {
            var joined = object['event_responses_v2']['events_joined'];
            var declined = object['event_responses_v2']['events_declined'];
            var interested = object['event_responses_v2']['events_interested'];
            for (var event in joined) {
              var model = EventModel.fromJson(event, profile!);
              model.response = EventResponse.joined;
              yield model;
            }
            for (var event in declined) {
              var model = EventModel.fromJson(event, profile!);
              model.response = EventResponse.declined;
              yield model;
            }
            for (var event in interested) {
              var model = EventModel.fromJson(event, profile!);
              model.response = EventResponse.interested;
              yield model;
            }
          } else if (object.containsKey('events_invited_v2')) {
            var eventsInvited = object['events_invited_v2'] as List<dynamic>;
            for (var event in eventsInvited) {
              yield EventModel.fromJson(event, profile!);
            }
          } else if (object.containsKey("poll_votes_v2")) {
            for (var poll in object["poll_votes_v2"]) {
              var pollModel = PostPollModel.fromJson(poll, profile!);
              _appLogger.logger
                  .info("Parsed Facebook Poll: ${pollModel.toString()}");
              yield pollModel;
            }
          } else if (object.containsKey("group_posts_v2")) {
            for (var post in object["group_posts_v2"]) {
              var keysInPost = ParseHelper.findAllKeysInJson(post);
              if (keysInPost.contains("poll")) {
                var postPollModel = PostPollModel.fromJson(post, profile!);
                _appLogger.logger
                    .info("Parsed Facebook Poll: ${postPollModel.toString()}");
                yield postPollModel;
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

      var groupsPath = paths.firstWhere(
          (element) => element.contains('your_group_membership_activity'));
      var groupsStream = parseFile(File(groupsPath), profile: profile)
          .where((event) => event is GroupModel);
      var groups = await groupsStream.toList();
      if (groups.isNotEmpty) {
        var groupModels = groups.cast<GroupModel>();
        paths.remove(profilePath);
        paths.remove(groupsPath);
        return Tuple2(groupModels, paths);
      } else {
        paths.remove(groupsPath);
        paths.remove(profilePath);
        return Tuple2([], paths);
      }
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
