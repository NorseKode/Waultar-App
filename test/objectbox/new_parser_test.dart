// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/inode.dart';
import 'package:path/path.dart' as dart_path;
import 'package:waultar/core/inodes/new_parser.dart';
import 'package:waultar/core/inodes/tree_parser.dart';

import 'setup.dart';

Future<void> main() async {
  late final ObjectBoxMock _context;
  late final DataPointRepository _dataRepo;
  late final DataCategoryRepository _categoryRepo;
  late final DataPointNameRepository _nameRepo;
  late final TreeParser _parser;

  final scriptDir = File(Platform.script.toFilePath()).parent;

  var largeMotherfucker = dart_path
      .normalize('${scriptDir.path}/test/parser/data/large_random_json.json');

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
  var autofill_information = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/messages/autofill_information.json');
  var fbPosts = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/posts/your_posts_1.json');
  var profileInformation = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/profile_information/profile_information.json');
  var profileInformationV2 = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/profile_information/v2_profile_information.json');
  var instantGames = dart_path.normalize(
      '${scriptDir.path}/test/objectbox/data/Facebook/facebook_gaming/instant_games.json');

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
    _parser = TreeParser(_categoryRepo, _nameRepo, _dataRepo);
  });

  printResultName(DataPointName name) {
    print('name                 -> ${name.name}');
    print('amount               -> ${name.count}');
    print('linked datapoints    -> ${name.dataPoints.length}');
    print('linked names         -> ${name.children.length}');
    print('category             -> ${name.dataCategory.target!.name}');
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
    // ? looks good
    test(" - facebook posts", () async {
      var result = await _parser.parsePath(fbPosts);

      printResultName(result);
    });

    // ? looks good
    test(" - facebook messages autofill_information", () async {
      var result = await _parser.parsePath(autofill_information);

      printResultName(result);
    });

    // ? looks good
    test(" - facebook profile information", () async {
      var result = await _parser.parsePath(profileInformationV2);

      // expect(result.length, 1);
      printResultName(result);

      for (var child in result.children) {
        printResultName(child);
      }
    });

    // ? looks good
    test(" - facebook messages", () async {
      var result = await _parser.parsePath(message);

      // var names = _nameRepo.getAllNames();
      printResultName(result);
      for (var child in result.children) {
        for (var point in child.dataPoints) {
          print(point.toString());
        }
      }
    });

    // this badboy has a lot of nested datapoints, that should not be included in a parent ..
    test(" - recently_viewed stupid bitch", () async {
      var result = await _parser.parsePath(recentlyViewed);

      printResultName(result);
    });

    // ? looks good
    test(" - facebook comments", () async {
      var result = await _parser.parsePath(comments);
      expect(result.name, 'comments');
      expect(result.count, 6);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.name, 'Reactions');
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 6);
    });

    // ? looks good
    test(" - facebook reactions", () async {
      var result = await _parser.parsePath(reactions);
      expect(result.count, 17);
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 17);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.name, 'Reactions');
    });

    // ? looks good
    test(" - facebook gaming", () async {
      var result = await _parser.parsePath(instantGames);
      expect(result.count, 14);
      expect(result.name, 'instant games played');
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 14);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.name, 'Gaming');
    });

    test(" - your topics", () async {
      var result = await _parser.parsePath(yourTopics);
      expect(result.count, 1);
      expect(result.name, 'inferred topics');
      expect(result.children.length, 0);
      expect(result.dataPoints.length, 1);
      expect(result.dataCategory.hasValue, true);
      expect(result.dataCategory.target!.name, 'Advertisement');
      printResultName(result);
    });
  });
}
