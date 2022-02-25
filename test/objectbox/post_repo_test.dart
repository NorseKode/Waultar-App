import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
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

import 'setup.dart';

Future<void> main() async {
  late final ObjectBoxMock _context;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;
  late final IPostRepository _repo;
  late final ProfileModel profileModel;

  var testProfile = ProfileObjectBox(
      uri: "test/path",
      fullName: "John Doe",
      createdTimestamp: DateTime.now(),
      raw: "raw");

  T testRunnerPut<T>(T testEntity) {
    var box = _context.store.box<T>();

    var id = box.put(testEntity);

    return box.get(id)!;
  }

  tearDownAll(() async {
    _context.store.close();
    await deleteTestDb();
  });

  setUpAll(() async {
    await deleteTestDb();
    _context = await ObjectBoxMock.create();
    _entityDirector = ObjectBoxDirector(_context);
    _modelDirector = ModelDirector();
    _repo = PostRepository(_context, _entityDirector, _modelDirector);
    var service = _context.store
        .box<ServiceObjectBox>()
        .query(ServiceObjectBox_.name.equals("Facebook"))
        .build()
        .findFirst()!;
    // var serviceModel = _modelDirector.make<ServiceModel>(service);
    testProfile.service.target = service;
    var profile = testRunnerPut<ProfileObjectBox>(testProfile);
    profileModel = _modelDirector.make<ProfileModel>(profile);
  });

  group('Test entity insertion and retrieval in objectbox: ', () {
    test('- created Profile id is 1', () {
      var result = _context.store.box<ProfileObjectBox>().get(1)!;

      var service = _context.store
          .box<ServiceObjectBox>()
          .query(ServiceObjectBox_.name.equals("Facebook"))
          .build()
          .findFirst()!;
      expect(result.fullName, testProfile.fullName);
      expect(result.service.target!.name, profileModel.service.name);
      expect(result.service.target!.id, service.id);
    });

    test('- insert post without any relations besides profile', () {
      var post = PostModel(
          profile: profileModel,
          raw: "this is some raw json",
          timestamp: DateTime.now());
      _repo.addPost(post);

      var createdPost = _repo.getSinglePost(1)!;

      expect(createdPost.id, 1);
      expect(createdPost.profile.fullName, testProfile.fullName);
      expect(createdPost.raw, post.raw);
    });

    test('- insert post with media relations', () {
      var datetime = DateTime.now();
      var post = PostModel(
          profile: profileModel, raw: 'blob json', timestamp: datetime);

      var image1 = ImageModel(
          profile: profileModel,
          raw: 'blob',
          uri: Uri(path: 'waultar/media/image1'));
      var image2 = ImageModel(
          profile: profileModel,
          raw: 'blob',
          uri: Uri(path: 'waultar/media/image2'),
          title: 'image with title');
      var video1 = VideoModel(
          profile: profileModel,
          raw: 'blob',
          uri: Uri(path: 'waultar/media/video1'));
      var link1 = LinkModel(
          profile: profileModel,
          raw: 'raw',
          uri: Uri(path: 'waultar/media/link1'));
      var file1 = FileModel(
          profile: profileModel,
          raw: 'raw',
          uri: Uri(path: 'waultar/media/file1'));

      post.medias = [];
      post.medias!.addAll([image1, image2, video1, link1, file1]);

      int id = _repo.addPost(post);
      var createdModel = _repo.getSinglePost(id)!;

      expect(createdModel.medias!.length, 5);

      var imageCount = _context.store.box<ImageObjectBox>().count();
      expect(imageCount, 2);

      var videoCount = _context.store.box<VideoObjectBox>().count();
      expect(videoCount, 1);

      var linkCount = _context.store.box<LinkObjectBox>().count();
      expect(linkCount, 1);

      var fileCount = _context.store.box<FileObjectBox>().count();
      expect(fileCount, 1);
    });

    test('- insert post with existing file uri', () {
      var fileWithSameUri = FileModel(
          profile: profileModel,
          raw: 'raw',
          uri: Uri(path: 'waultar/media/file1'));
      var post = PostModel(
          profile: profileModel, raw: 'blob', timestamp: DateTime.now());
      post.medias = [];
      post.medias!.add(fileWithSameUri);

      _repo.addPost(post);

      var fileCount = _context.store.box<FileObjectBox>().count();
      expect(fileCount, 1);
    });

    test('- insert post with event', () {
      var coordinate = CoordinateModel(id: 0, latitude: 2.0, longitude: 3.0);
      var place = PlaceModel(
          profile: profileModel,
          raw: 'blob',
          name: 'test name',
          coordinate: coordinate);
      // ignore: unused_local_variable
      var event = EventModel(
          profile: profileModel,
          raw: 'raw',
          name: 'test event',
          isUsers: true,
          place: place,
          response: EventResponse.interested);

      var post = PostModel(
        profile: profileModel,
        raw: 'raw',
        timestamp: DateTime.now(),
      );
      // event: event);

      int id = _repo.addPost(post);
      // ignore: unused_local_variable
      var createdPost = _repo.getSinglePost(id);

      // var eventEntity = _context.store
      //     .box<EventObjectBox>()
      //     .query(EventObjectBox_.name.equals('test event'))
      //     .build()
      //     .findFirst()!;

      // expect(eventEntity.response, event.response);
      // expect(eventEntity.place.hasValue, true);
      // expect(eventEntity.place.target!.name, place.name);
      // expect(createdPost.event!.name, event.name);
    });
  });
}
