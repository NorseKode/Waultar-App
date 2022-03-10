// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/inodes/inode_parser.dart';
import 'package:path/path.dart' as dart_path;
import 'package:waultar/core/inodes/new_parser.dart';

import 'setup.dart';

Future<void> main() async {
  late final ObjectBoxMock _context;
  late final DataPointRepository _dataRepo;
  late final DataCategoryRepository _categoryRepo;
  late final DataPointNameRepository _nameRepo;
  late final NewParser _parser;

  final scriptDir = File(Platform.script.toFilePath()).parent;
  var profile = dart_path.normalize(
      '${scriptDir.path}/test/parser/data/v2_profile_information.json');
  var eventInvitations = dart_path
      .normalize('${scriptDir.path}/test/parser/data/event_invitations.json');
  var facebookPosts = dart_path
      .normalize('${scriptDir.path}/test/parser/data/your_posts_1.json');
  var pagesFollowed = dart_path
      .normalize('${scriptDir.path}/test/inodes/data/pages_followed.json');
  var eventResponses = dart_path.normalize(
      '${scriptDir.path}/test/parser/data/your_event_responses.json');

  var largeMotherfucker = dart_path
      .normalize('${scriptDir.path}/test/parser/data/large_random_json.json');

  // facebook dump imitator:
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
  var autofill_information = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/messages/autofill_information.json');
  var fbPosts = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/posts/your_posts_1.json');
  var profileInformation = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/profile_information/profile_information.json');
  var profileInformationV2 = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/profile_information/v2_profile_information.json');

  List<String> paths = [];
  paths.add(message);
  paths.add(reactions);

  tearDownAll(() async {
    _context.store.close();
    await deleteTestDb();
  });

  setUpAll(() async {
    await deleteTestDb();
    _context = await ObjectBoxMock.create();
    _dataRepo = DataPointRepository(_context);
    _categoryRepo = DataCategoryRepository(_context);
    _nameRepo = DataPointNameRepository(_context);
    _parser = NewParser(_categoryRepo, _nameRepo, _dataRepo);
  });

  group('Test parsing of actual facebook data', () {
    test(" - facebook posts", () async {
      var result = await _parser.parseFromPath(fbPosts);

      expect(result.length, 14);
      expect(result.first.dataPointName.target!.name, "your posts");
      expect(result.first.dataPointName.target!.dataCategory.target!.name, "Posts");

      // for (var item in result) {
      //   print(item.toString());
      //   if (item.children.isNotEmpty) {
      //     print("children:");
      //     for (var child in item.children) {
      //       print(child.toString());
      //     }
      //   }
      // }
    });

    test(" - facebook profile information", () async {
      var result = await _parser.parseFromPath(profileInformationV2);

      expect(result.length, 1);
      var children = result.first.children;
      expect(children.length, 13);
      var childrenNames = children.map((element) => element.dataPointName.target!.name).toSet();
      expect(childrenNames.length, 11);

      // for (var item in result) {
      //   print(item.toString());
      //   if (item.children.isNotEmpty) {
      //     print("children:");
      //     for (var child in item.children) {
      //       print(child.toString());
      //     }
      //   }
      // }
    });

    test(" - facebook messages", () async {
      var result = await _parser.parseFromPath(message);

      expect(result.length, 1);
      expect(result.first.dataPointName.target!.name, "Lukas Vinther Offenberg Larsen");
      expect(result.first.dataPointName.target!.dataCategory.target!.name, "Messaging");
      var children = result.first.children;
      expect(children.length, 9);
      var childrenNames = children.map((element) => element.dataPointName.target!.name).toSet();
      expect(childrenNames.length, 2);

      // for (var item in result) {
      //   print(item.toString());
      //   if (item.children.isNotEmpty) {
      //     print("children:");
      //     for (var child in item.children) {
      //       print(child.toString());
      //     }
      //   }
      // }
    });
  });
}
