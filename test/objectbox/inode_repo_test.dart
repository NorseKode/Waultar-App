// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
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

  var largeMotherfucker = dart_path
      .normalize('${scriptDir.path}/test/parser/data/large_random_json.json');

  List<String> paths = [];
  paths.add(profile);
  paths.add(eventInvitations);
  paths.add(facebookPosts);
  paths.add(largeMotherfucker);

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
    _parser =
        InodeParserService(InodeParser(), _categoryRepo, _nameRepo, _dataRepo);
  });

  group('Test parsing of many paths with service', () {
    test(' - inode parser', () async {
      Stopwatch stopwatch = Stopwatch()..start();

      await _parser.parse(paths);

      print('parsing executed in ${stopwatch.elapsed}');

      var count = _dataRepo.count();
      var categoryCont = _categoryRepo.count();

      print("amount parsed : $count \n");
      print("amount of categories : $categoryCont \n");

      for (var name in _nameRepo.getAllNames()) {
        print(name);
      }
    });
  });
}
