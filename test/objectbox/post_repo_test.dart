import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/objectbox_director.dart';
import 'package:waultar/data/repositories/post_repo.dart';

import 'setup.dart';

Future<void> main() async {
  late final ObjectBoxMock _context;
  late final IObjectBoxDirector _director;
  late final IPostRepository _repo;
  late final ProfileModel profileModel;
  late final ServiceModel serviceModel;

  var testService = ServiceObjectBox(
      name: "facebook", company: "meta", image: "path to image");
  var testProfile = ProfileObjectBox(
      uri: "test/path",
      fullName: "John Doe",
      createdTimestamp: DateTime.now(),
      raw: "raw");
  testProfile.service.target = testService;

  T testRunnerPut<T>(T testEntity) {
    var box = _context.store.box<T>();

    var id = box.put(testEntity);

    return box.get(id)!;
  }

  setUpAll(() async {
    await deleteTestDb();
    _context = await ObjectBoxMock.create();
    _director = ObjectBoxDirector(_context);
    _repo = PostRepository(_context, _director);
    var service = testRunnerPut<ServiceObjectBox>(testService);
    serviceModel = ServiceModel(
        service.id, service.name, service.company, Uri(path: service.image));
    var profile = testRunnerPut<ProfileObjectBox>(testProfile);
    profileModel = ProfileModel(
        id: profile.id,
        service: serviceModel,
        uri: Uri(path: '/'),
        fullName: profile.fullName,
        emails: [],
        createdTimestamp: profile.createdTimestamp,
        activities: [],
        raw: profile.raw);
  });

  tearDownAll(() async {
    _context.store.close();
    await deleteTestDb();
  });

  group('Test entity insertion and retrieval in objectbox: ', () {
    test('- created Profile id is 1', () {
      var result = _context.store.box<ProfileObjectBox>().get(1)!;

      expect(result.fullName, testProfile.fullName);
      expect(result.service.target!.name, profileModel.service.name);
    });

    test('- insert post without any relations besides profile', () {
      var post = PostModel(
          profile: profileModel,
          raw: "this is some raw json",
          timestamp: DateTime.now());
      _repo.addPost(post);

      var createdEntity = _repo.getSinglePost(1);

      expect(createdEntity.id, 1);
      expect(createdEntity.profile.fullName, testProfile.fullName);
      expect(createdEntity.raw, post.raw);
    });
  });
}
