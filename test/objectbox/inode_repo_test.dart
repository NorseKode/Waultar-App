import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/inode_parser.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/model_builders/model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/objectbox_director.dart';
import 'package:waultar/data/repositories/post_repo.dart';
import 'package:path/path.dart' as dart_path;


import 'setup.dart';

Future<void> main() async {
  late final ObjectBoxMock _context;
  late final DataPointRepository _dataRepo;
  late final DataCategoryRepository _categoryRepo;
  late final DataPointNameRepository _nameRepo;
  late final InodeParserService _parser;

  final scriptDir = File(Platform.script.toFilePath()).parent;
  var profile = dart_path.normalize('${scriptDir.path}/test/parser/data/v2_profile_information.json');
  var eventInvitations = dart_path.normalize('${scriptDir.path}/test/parser/data/event_invitations.json');
  var facebookPosts = dart_path.normalize('${scriptDir.path}/test/parser/data/your_posts_1.json');

  var largeMotherfucker = dart_path.normalize('${scriptDir.path}/test/parser/data/large_random_json.json');

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
      await _parser.parse(paths);

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
