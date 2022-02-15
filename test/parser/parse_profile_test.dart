import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/models/model_helper.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/parsers/facebook_parser.dart';
import 'package:waultar/core/parsers/instagram_parser.dart';

import '../test_helper.dart';

main() {
  var facebookProfile =
      File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "facebook_profile.json"));
  var instagramProfile =
      File(path_dart.join(TestHelper.pathToCurrentFile(), "data", "instagram_profile.json"));

  group("Testig parsing of profile data: ", () {
    test('Facebook', () async {
      var result = await FacebookParser().parseFile(facebookProfile).toList();

      expect(1, result.length);

      ProfileModel profile = result.first;

      expect(profile.bio, null);
      expect(profile.fullName, "REDACTED FULLNAME");
      expect(profile.dateOfBirth, DateTime.utc(2021, 2, 12));
      expect(profile.gender, "MALE");
      expect(profile.bloodInfo, "{blood_donor_status: unregistered}");
      expect(profile.profilePicture, null);
      expect(profile.phoneNumbers!.length, 1);
      expect(profile.uri.path, "https%3A//www.facebook.com/profile");
      expect(profile.username, "cyb0rgninj4");
      expect(profile.otherNames!.length, 1);
      expect(profile.currentCity, "Gammel Holte, Kobenhavn, Denmark");
      expect(profile.createdTimestamp, ModelHelper.intToTimestamp(1236956306));
      expect(profile.websites, null);
      expect(profile.metadata!.length, 9);
    });

    test('Instagram', () async {
      var result = await InstagramParser().parseFile(instagramProfile).toList();

      expect(result.length, 1);

      ProfileModel profile = result.first;

      expect(profile.bio, "REDACTED BIO");
      expect(profile.fullName, "REDACTED NAME");
      expect(profile.dateOfBirth, DateTime.utc(2021, 2, 12));
      expect(profile.gender, "male");
      expect(profile.profilePicture!.uri.path,
          "media/other/33479950_2070043303318549_5971154643487555584_n_17935673491101223.jpg");
      expect(profile.phoneNumbers!.length, 1);
      expect(profile.username, "REDACTED USERNAME");
      expect(profile.currentCity, "REDACTED CITY");
      expect(profile.websites!.length, 1);
      expect(profile.metadata!.length, 1);
    });
  });
}