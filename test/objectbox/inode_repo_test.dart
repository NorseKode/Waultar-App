// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/inodes/inode_parser.dart';
import 'package:path/path.dart' as dart_path;

import 'setup.dart';

Future<void> main() async {
  late final ObjectBoxMock _context;
  late final DataPointRepository _dataRepo;
  late final DataCategoryRepository _categoryRepo;
  late final DataPointNameRepository _nameRepo;
  late final InodeParserService _parser;

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

  final DataCategory testCategory =
      DataCategory(name: 'Test', matchingFolders: []);

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
    _parser = InodeParserService(_categoryRepo, _nameRepo, _dataRepo);
  });

  group('Test parsing of actual facebook data', () {
    test(" - event responses", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(eventResponses), testCategory);
      var result = await stream.toList();

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children:");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });

    test(" - facebook messages autofill_information", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(autofill_information), testCategory);
      var result = await stream.toList();

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children:");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });

    test(" - facebook posts", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(facebookPosts), testCategory);
      var result = await stream.toList();

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children:");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });

    test(" - facebook profile", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(profile), testCategory);
      var result = await stream.toList();

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children:");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });

    test(" - reactions", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(reactions), testCategory);
      var result = await stream.toList();

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children:");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });

    test(" - comments", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(comments), testCategory);
      var result = await stream.toList();

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children:");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });

    test(" - your topics", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(yourTopics), testCategory);
      var result = await stream.toList();

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children:");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });

    test(" - messages", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(message), testCategory);
      var result = await stream.toList();

      print(result.length);

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children: ");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });

    test(" - recently viewed", () async {
      var parser = InodeParser();
      var stream = parser.parseFile(File(recentlyViewed), testCategory);
      var result = await stream.toList();

      for (var item in result) {
        if (item is DataPoint) {
          print(item.toString());
          if (item.children.isNotEmpty) {
            print("children:");
            for (var child in item.children) {
              print(child.toString());
            }
          }
        }
      }
    });
  });

  group('Test parsing of many paths with service', () {
    test(' - inode parser', () async {
      Stopwatch stopwatch = Stopwatch()..start();

      await _parser.parse(paths);

      print('parsing executed in ${stopwatch.elapsed}');

      var count = _dataRepo.count();
      var categoryCont = _categoryRepo.count();
      var categories = _categoryRepo.getAllCategories();
      for (var item in categories) {
        print("Category name: ${item.name}");
        print("Category count: ${item.count}");
        print("Category related datapoint names:");
        for (var name in item.dataPointNames) {
          print("\t${name.name}");
        }
        print("\n");
      }

      print("amount parsed : $count");
      print("amount of categories : $categoryCont \n");

      print("All parsed datapoint names :");
      for (var name in _nameRepo.getAll()) {
        print("\t ${name.name}");
        print("\t ${name.count}");
        print("\t ${name.dataCategory.target!.name}");
        print("\n");
      }

      print("\n");
    });
  });
}
