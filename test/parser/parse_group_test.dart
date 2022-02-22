import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';

import '../test_helper.dart';

main() {
  var facebookProfile = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "profile_information.json"));

  setUpAll(() {
    TestHelper.clearTestLogger();
    TestHelper.createTestLogger();
  });

  group("Testig parsing of group data: ", () {
    test('Facebook', () async {
      var parser = FacebookParser();
      var profile = (await parser.parseProfile([facebookProfile.path])).item1;

      var result =
          (await parser.parseGroupNames([facebookProfile.path], profile)).item1;
      var groups = <GroupModel>[];
      for (var group in result) {
        groups.add(group);
      }

      expect(profile.fullName, "REDACTED FULLNAME");
      expect(groups.length, 2);
      expect(groups.first.name, 'Group 2');
    });
  });
}
