import 'dart:io';

import 'package:path/path.dart' as path_dart;
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/core/inodes/data_category_repo.dart';
import 'package:waultar/core/inodes/datapoint_name_repo.dart';
import 'package:waultar/core/inodes/datapoint_repo.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/inodes/tree_parser.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';
import 'package:waultar/startup.dart';

class TestHelper {
  static ProfileDocument profileDocument = ProfileDocument(
    name: 'Test Profile',
  );
  static final serviceDocument = ServiceDocument(
    serviceName: 'TestService',
    companyName: 'Company Name',
    image: "No Image",
  );
  static ServiceDocument getFacebookService(ObjectBox context) {
    return context.store
        .box<ServiceDocument>()
        .query(ServiceDocument_.serviceName.equals('Facebook'))
        .build()
        .findUnique()!;
  }

  static ServiceDocument getInstagramService(ObjectBox context) {
    return context.store
        .box<ServiceDocument>()
        .query(ServiceDocument_.serviceName.equals('Instagram'))
        .build()
        .findUnique()!;
  }
  static ProfileDocument createTestProfile(ObjectBox context) {
    var box = context.store.box<ProfileDocument>();
    int created = box.put(ProfileDocument(name: 'Test Profile Name'));
    return box.get(created)!;
  }

  static ProfileModel facebookProfile = ProfileModel(
    activities: [],
    createdTimestamp: DateTime.now(),
    emails: [],
    fullName: '',
    raw: '',
    uri: Uri(),
    service: facebook,
    basePathToFiles: "",
  );
  static ProfileModel instagramProfile = ProfileModel(
    activities: [],
    createdTimestamp: DateTime.now(),
    emails: [],
    fullName: '',
    raw: '',
    uri: Uri(),
    basePathToFiles: "",
    service: instagram,
  );

  static getTreeParser() async {
    await deleteTestDb();
    var _context = await createTestDb();
    var _dataRepo = DataPointRepository(_context);
    var _categoryRepo = DataCategoryRepository(_context);
    var _nameRepo = DataPointNameRepository(_context);
    var _parser = TreeParser(_categoryRepo, _nameRepo, _dataRepo);
    _parser.basePathToFiles = "";
    return _parser;
  }

  static ServiceModel facebook = ServiceModel(
      id: 1, name: "facebook", company: "meta", image: Uri(path: ""));
  static ServiceModel instagram = ServiceModel(
      id: 2, name: "instagram", company: "meta", image: Uri(path: ""));

  // static final _locator = GetIt.instance;
  static final _logFilePath = path_dart
      .normalize(path_dart.join(
              path_dart.dirname(Platform.script.path), "test", "parser") +
          "/logs.txt")
      .substring(1);
  static final _appLogger = AppLogger.test(detectPlatform(), _logFilePath);

  static String pathToCurrentFile({String folder = 'parser'}) {
    return path_dart
        .normalize(path_dart.join(
            path_dart.dirname(Platform.script.path), "test", folder))
        .substring(1);
  }

  static void createTestLogger() {
    locator.registerSingleton<AppLogger>(_appLogger, instanceName: 'logger');
  }

  static void clearTestLogger() {
    var file = File(_logFilePath);
    file.writeAsStringSync("");
  }

  static Future<ObjectBox> createTestDb() async {
    return ObjectBox.create('test/objectbox');
  }

  static Future<void> deleteTestDb() async {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final datafile =
        File(path_dart.normalize('${scriptDir.path}/test/objectbox/data.mdb'));
    final lockfile =
        File(path_dart.normalize('${scriptDir.path}/test/objectbox/lock.mdb'));
    try {
      await datafile.delete();
      await lockfile.delete();
    } catch (e) {
      return;
    }
  }

  static void seedForTimeBuckets(ObjectBox context) {
    var timestamps = <int>[
      1647774619, // Sun Mar 20 2022 12:10:19 GMT
      1647601819, // Fri Mar 18 2022 12:10:19 GMT
      1642749019, // Fri Jan 21 2022 08:10:19 GMT
      1628662219, // Wed Aug 11 2021 08:10:19 GMT
      1623651019, // Mon Jun 14 2021 08:10:19 GMT
      1623661819, // Mon Jun 14 2021 11:10:19 GMT
      1623636799, // Mon Jun 14 2021 04:13:19 GMT
      1609125199, // Mon Dec 28 2020 04:13:19 GMT
      1411531879, // Wed Sep 24 2014 06:11:19 GMT
      1448169079, // Sun Nov 22 2015 06:11:19 GMT
    ];
    final testProfile = createTestProfile(context);
    final _categoryBox = context.store.box<DataCategory>();
    var posts = _categoryBox
        .query(DataCategory_.dbCategory.equals(CategoryEnum.posts.index))
        .build()
        .findUnique()!;
    var comments = _categoryBox
        .query(DataCategory_.dbCategory.equals(CategoryEnum.comments.index))
        .build()
        .findUnique()!;
    var fbService = context.store
        .box<ServiceDocument>()
        .query(ServiceDocument_.serviceName.equals('Facebook'))
        .build()
        .findUnique()!;
    var yourPosts = DataPointName(name: 'your posts');
    yourPosts.service.target = fbService;
    yourPosts.dataCategory.target = posts;
    int i = 0;
    for (; i < timestamps.length / 2; i++) {
      var dataPoint = DataPoint.parse(posts, yourPosts, fbService, testProfile, json, "");
    }
    for (; i < timestamps.length; i++) {
      
    }
  }
}
