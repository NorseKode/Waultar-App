import 'dart:io';

import 'package:path/path.dart' as path_dart;
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/misc/service_document.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';
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
    var service = getFacebookService(context);
    var profile = ProfileDocument(name: 'Test Profile Name');
    profile.service.target = service;
    int created = box.put(profile);
    var entity = box.get(created)!;
    return entity;
  }

  static ServiceModel facebook = ServiceModel(
      id: 1, name: "facebook", company: "meta", image: Uri(path: ""));
  static ServiceModel instagram = ServiceModel(
      id: 2, name: "instagram", company: "meta", image: Uri(path: ""));

  static Future<ObjectBox> createTestDb() async {
    return ObjectBox.create('test/objectbox');
  }

  static Future<void> deleteTestDb() async {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final datafile = File(path_dart
        .normalize('${scriptDir.path}/test/waultar/objectbox/data.mdb'));
    final lockfile = File(path_dart
        .normalize('${scriptDir.path}/test/waultar/objectbox/lock.mdb'));
    try {
      await datafile.delete();
      await lockfile.delete();
    } catch (e) {
      return;
    }
  }

  /// deletes the test folders but not the logs file
  static Future<void> deleteTestFolders() async {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final dbDir = Directory(
        path_dart.normalize('${scriptDir.path}/test/waultar/objectbox'));
    final extractsDir = Directory(
        path_dart.normalize('${scriptDir.path}/test/waultar/extracts'));
    try {
      await dbDir.delete(recursive: true);
      await extractsDir.delete(recursive: true);
    } catch (e) {
      // print(e);
      return;
    }
  }

  static Future<void> runStartupScript() async {
    await deleteTestFolders();
    await setupServices(testing: true);
  }

  static Future<void> tearDownServices() async {
    var context = locator.get<ObjectBox>(instanceName: 'context');
    context.store.close();
    await deleteTestFolders();
  }

  static ProfileDocument seedForTimeBuckets() {
    var context = locator.get<ObjectBox>(instanceName: 'context');
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
    var posts = DataCategory(
      matchingFoldersFacebook: [],
      matchingFoldersInstagram: [],
      category: CategoryEnum.posts,
    );

    var comments = DataCategory(
      matchingFoldersFacebook: [],
      matchingFoldersInstagram: [],
      category: CategoryEnum.comments,
    );

    final _categoryBox = context.store.box<DataCategory>();
    var yourPosts = DataPointName(name: 'your posts');
    yourPosts.profile.target = testProfile;

    int i = 0;
    for (; i < timestamps.length / 2; i++) {
      var data = {
        'title': 'test title',
        'attachments': [],
        'data': {
          'post': 'this is a post',
          'data': {'created_timestamp': timestamps[i]}
        },
      };
      var dataPoint = DataPoint.parse(posts, yourPosts, testProfile, data, "");
      yourPosts.dataPoints.add(dataPoint);
    }

    var yourComments = DataPointName(name: 'your comments');
    yourComments.profile.target = testProfile;
    for (; i < timestamps.length; i++) {
      var data = {
        'title': 'test title',
        'attachments': [],
        'data': {
          'post': 'this is a post',
          'data': {'created_timestamp': timestamps[i]},
          'timestamp': timestamps[i]
        },
        'updated_timestamp': timestamps[i - 1]
      };
      var dataPoint =
          DataPoint.parse(comments, yourComments, testProfile, data, "");
      yourComments.dataPoints.add(dataPoint);
    }
    comments.dataPointNames.add(yourComments);
    posts.dataPointNames.add(yourPosts);
    _categoryBox.putMany([posts, comments]);
    return testProfile;
  }
}
