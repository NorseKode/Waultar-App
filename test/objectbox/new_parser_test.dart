// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:path/path.dart' as dart_path;
import 'package:waultar/core/inodes/tree_parser.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

import '../test_helper.dart';
import 'test_utils.dart';

Future<void> main() async {
  late final ObjectBox _context;
  late final DataPointRepository _dataRepo;
  late final DataCategoryRepository _categoryRepo;
  late final DataPointNameRepository _nameRepo;
  late final TreeParser _parser;
  late final ServiceDocument service;
  late final ProfileDocument profile;

  final scriptDir = File(Platform.script.toFilePath()).parent;

  // facebook dump mock data:
  var recentlyViewed = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/your_interactions_on_facebook/recently_viewed.json');
  var reactions = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/comments_and_reactions/posts_and_comments.json');
  var comments = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/comments_and_reactions/comments_and_reactions.json');
  var message = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/messages/inbox/lukasvintheroffenberglarsen_2qr6kux07q/message_1.json');
  var yourTopics = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/your_topics/your_topics.json');
  var autofillInformation = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/messages/autofill_information.json');
  var fbPosts = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/posts/your_posts_1.json');
  var profileInformationV2 = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/profile_information/v2_profile_information.json');
  var instantGames = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/facebook_gaming/instant_games.json');
  var yourFacebookActivityHistory = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/security_and_login_information/your_facebook_activity_history.json');

  tearDownAll(() async {
    _context.store.close();
    await TestUtils.deleteTestDb();
  });

  setUpAll(() async {
    await TestUtils.deleteTestDb();
    _context = await TestUtils.createTestDb();
    _dataRepo = DataPointRepository(_context);
    _categoryRepo = DataCategoryRepository(_context);
    _nameRepo = DataPointNameRepository(_context);
    _parser = TreeParser(_categoryRepo, _nameRepo, _dataRepo);
    service = TestHelper.serviceDocument;
    profile = TestHelper.profileDocument;
  });

  printResultName(DataPointName name) {
    print('name                 -> ${name.name}');
    print('amount               -> ${name.count}');
    print('linked datapoints    -> ${name.dataPoints.length}');
    print('linked names         -> ${name.children.length}');
    print('category             -> ${name.dataCategory.target!.category.name}');
    print('');
    print('children names : ');
    if (name.children.isEmpty) {
      print(' - NONE');
    } else {
      for (var childName in name.children) {
        print('   ${childName.name} ${childName.count}');
      }
    }
    print('');
    print('direct linked datapoints:');
    if (name.dataPoints.isEmpty) {
      print(' - NONE');
    } else {
      for (var point in name.dataPoints) {
        print(point.toString());
      }
    }
    print('');
  }

  group('Test parsing of actual facebook data', () {
    test(" - facebook posts", () async {
      var result = await _parser.parsePath(fbPosts, profile, service);
      expect(result.name, 'your posts');
      expect(result.count, 14);
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 14);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Posts');
    });

    test(' - facebook activity history in security and login information',
        () async {
      var result = await _parser.parsePath(
          yourFacebookActivityHistory, profile, service);

      expect(result.name, 'last activity time');
      expect(result.dataPoints.length, 0);
      expect(result.children.length, 3);
      expect(result.count, 3);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Logged Data');
    });

    test(" - facebook messages autofillInformation", () async {
      var result = await _parser.parsePath(autofillInformation, profile, service);
      expect(result.name, 'autofill information');
      expect(result.dataPoints.length, 1);
      expect(result.children.length, 0);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Messaging');

      var dataMap = result.dataPoints.first.asMap;
      expect(dataMap.length, 9);
    });

    test(" - facebook profile information", () async {
      var result = await _parser.parsePath(profileInformationV2, profile, service);
      expect(result.name, 'profile');
      expect(result.count, 12);
      expect(result.dataPoints.length, 1);
      expect(result.children.length, 11);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Profile');

      var names = result.children.map((element) => element.name).toList();
      expect(names.contains('name'), true);
      expect(names.contains('emails'), true);
      expect(names.contains('birthday'), true);
      expect(names.contains('gender'), true);
      expect(names.contains('current city'), true);
      expect(names.contains('previous names'), true);
      expect(names.contains('other names'), true);
      expect(names.contains('previous relationships'), true);
      expect(names.contains('family members'), true);
      expect(names.contains('education experiences'), true);
      expect(names.contains('phone numbers'), true);

      var educationExpCount = result.children
          .firstWhere((element) => element.name == 'education experiences')
          .count;
      expect(educationExpCount, 2);
    });

    test(" - facebook messages", () async {
      var result = await _parser.parsePath(message, profile, service);
      expect(result.name, 'Lukas Vinther Offenberg Larsen');
      expect(result.count, 3);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Messaging');
      expect(result.dataPoints.length, 1);
      expect(result.children.length, 2);
      expect(result.children.first.count, 2);
      expect(result.children.first.name, 'participants');
      expect(result.children.last.count, 7);
      expect(result.children.last.name, 'messages');

      var dataMap = result.dataPoints.first.asMap;
      expect(dataMap.length, 5);
      expect(dataMap.containsKey('magic words'), true);
      expect(dataMap.containsValue('no data'), true);
    });

    // test(" - recently_viewed stupid bitch", () async {
    //   var result = await _parser.parsePath(recentlyViewed);
    //   printResultName(result);

    //   var dataPoints = _dataRepo.readAll();
    //   for (var item in dataPoints) {
    //     print(item.toString());
    //   }

    //   var names = _nameRepo.getAllNames();
    //   for (var name in names) {
    //     print(name);
    //   }
    // });

    test(" - facebook comments", () async {
      var result = await _parser.parsePath(comments, profile, service);
      expect(result.name, 'comments');
      expect(result.count, 6);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Reactions');
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 6);
    });

    test(" - facebook reactions", () async {
      var result = await _parser.parsePath(reactions, profile, service);
      expect(result.count, 17);
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 17);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Reactions');
    });

    test(" - facebook gaming", () async {
      var result = await _parser.parsePath(instantGames, profile, service);
      expect(result.count, 14);
      expect(result.name, 'instant games played');
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 14);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Gaming');
    });

    test(" - your topics", () async {
      var result = await _parser.parsePath(yourTopics, profile, service);
      expect(result.count, 1);
      expect(result.name, 'inferred topics');
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 1);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.category.name, 'Advertisement');
    });
  });
}
