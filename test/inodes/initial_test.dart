import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/inodes/inode_parser.dart';
import 'package:waultar/core/inodes/json_helper.dart';
import '../test_helper.dart';

main() {
  var facebookProfileV2File = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "v2_profile_information.json"));

  var eventsInvited = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "event_invitations.json"));

  var creatorBadges = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "creator_badges.json"));

  var groupMembershp = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "your_group_membership_activity.json"));

  var eventResponses = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "your_event_responses.json"));
  
  var yourSearches = File(path_dart.join(
      TestHelper.pathToCurrentFile(folder: 'inodes'), "data", "your_searches.json"));

  var facebookPosts = File(path_dart.join(
      TestHelper.pathToCurrentFile(folder: 'inodes'), "data", "your_posts_1.json"));

  final InodeParser _parser = InodeParser();

  setUpAll(() {
    TestHelper.clearTestLogger();
    TestHelper.createTestLogger();
  });

  group("Test parsing of multiple posts", () {

    test(" - facebook posts", () async {
      var resultStream = _parser.parseFile(facebookPosts);
      var result = await resultStream.toList();

      for (var item in result) {
        // ignore: avoid_print
        print(item.toString());
      }
    });

    test(" - facebook profile", () async {
      var resultStream = _parser.parseFile(facebookProfileV2File);
      var result = await resultStream.toList();

      for (var item in result) {
        // ignore: avoid_print
        print(item.toString());
      }
    });

    test(" - facebook event invitations", () async {
      var resultStream = _parser.parseFile(eventsInvited);
      var result = await resultStream.toList();

      for (var item in result) {
        // ignore: avoid_print
        print(item.toString());
      }
    });

    test(" - facebook groups creator badges", () async {
      var resultStream = _parser.parseFile(creatorBadges);
      var result = await resultStream.toList();

      for (var item in result) {
        // ignore: avoid_print
        print(item.toString());
      }
    });

    test(" - facebook groups membership", () async {
      var resultStream = _parser.parseFile(groupMembershp);
      var result = await resultStream.toList();

      for (var item in result) {
        // ignore: avoid_print
        print(item.toString());
      }
    });

    test(" - facebook event responses", () async {
      var resultStream = _parser.parseFile(eventResponses);
      var result = await resultStream.toList();

      for (var item in result) {
        // ignore: avoid_print
        print(item.toString());
      }
    });

    test(" - facebook search history", () async {
      var resultStream = _parser.parseFile(yourSearches);
      var result = await resultStream.toList();

      for (var item in result) {
        // ignore: avoid_print
        print(item.toString());
      }
    });

  });

  
}
