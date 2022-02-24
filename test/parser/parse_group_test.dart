import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';

import '../test_helper.dart';

main() {
  var facebookProfile = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "profile_information.json"));

  var creatorBadges = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "creator_badges.json"));

  var your_groups = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "your_groups.json"));

  late final FacebookParser parser;

  setUpAll(() {
    TestHelper.clearTestLogger();
    TestHelper.createTestLogger();
    parser = FacebookParser();
  });

  group("Testig parsing of group data: ", () {
    test('parse group names from profile_information.json', () async {
      var profile = (await parser.parseProfile([facebookProfile.path])).item1;

      var result =
          (await parser.parseGroupNames([facebookProfile.path], profile)).item1;
      var groups = <GroupModel>[];
      for (var group in result) {
        groups.add(group);
      }

      expect(profile.fullName, "REDACTED FULLNAME");
      expect(groups.length, 3);
      expect(groups.first.name, 'Group 3');
      expect(groups.last.name, 'Group 1');
    });

    test('parse groups belonging to user from your_groups.json', () async {
      var profile = (await parser.parseProfile([facebookProfile.path])).item1;
      var result = parser.parseFile(your_groups, profile: profile);
      var userGroupsStream = result.cast<GroupModel>();
      var userGroups = await userGroupsStream.toList();

      expect(userGroups.length, 2);
      expect(userGroups.first.isUsers, true);
      expect(userGroups.last.isUsers, true);
      expect(userGroups.first.name, 'Group 1');
      expect(userGroups.last.name, 'Group 2');
    });

    test('parse creator badges from creator_badges.json', () async {
      var profile = (await parser.parseProfile([facebookProfile.path])).item1;
      var result = parser.parseFile(creatorBadges, profile: profile);
      var groupsStream = result.cast<GroupModel>();
      var groups = await groupsStream.toList();

      expect(groups.length, 2);
      expect(groups.first.name, 'Group 1');
      expect(groups.last.name, 'Group 2');
      expect(groups.first.badge, 'Administrator');
      expect(groups.last.badge, 'Administrator');
    });
  });
}
