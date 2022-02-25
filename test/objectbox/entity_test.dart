import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/models/profile/friend_model.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';
import 'package:waultar/data/entities/misc/tag_objectbox.dart';
import 'package:waultar/data/entities/profile/friend_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';

import 'setup.dart';

Future<void> main() async {
  late final ObjectBoxMock _context;
  // TODO: test with service and email

  var testService = ServiceObjectBox(
      name: "facebook", company: "meta", image: "path to image");
  var testProfile = ProfileObjectBox(
      uri: "test/path",
      fullName: "John Doe",
      createdTimestamp: DateTime.now(),
      raw: "raw");
  testProfile.service.target = testService;

  var testFriend = FriendObjectBox(friendType: FriendType.unknown, raw: "raw");
  var testTag = TagObjectBox(name: "waultar");
  var testVideo =
      VideoObjectBox(uri: "uri", timestamp: DateTime.now(), raw: "raw");
  var testLink = LinkObjectBox(uri: "uri", raw: "raw");
  var testImage = ImageObjectBox(uri: "uri", raw: "raw");
  var testPost = PostObjectBox(raw: "raw", timestamp: DateTime.now());

  T testRunnerPut<T>(T testEntity) {
    var box = _context.store.box<T>();

    var id = box.put(testEntity);

    return box.get(id)!;
  }

  // T testRunnerGetter<T>(Condition<T> queryCondition) {
  //   var box = _context.store.box<T>();

  //   return box.query(queryCondition).build().findFirst()!;
  // }

  setUpAll(() async {
    await deleteTestDb();
    _context = await ObjectBoxMock.create();
    // profileBox = _context.store.box<ProfileObjectBox>();
    // serviceBox = _context.store.box<ServiceObjectBox>();
  });

  tearDownAll(() async {
    _context.store.close();
    await deleteTestDb();
  });

  group('Test entity insertion and retrieval in objectbox: ', () {
    test('- insert Profile', () {
      var result = testRunnerPut<ProfileObjectBox>(testProfile);

      expect(result.fullName, testProfile.fullName);
      expect(result.service.target!.name, testProfile.service.target!.name);
    });

    test('- insert Friend', () {
      var result = testRunnerPut<FriendObjectBox>(testFriend);

      expect(result.friendType, testFriend.friendType);
    });

    test("- insert Tag", () {
      var result = testRunnerPut<TagObjectBox>(testTag);

      expect(result.name, testTag.name);
    });

    test("- insert Video", () {
      var result = testRunnerPut<VideoObjectBox>(testVideo);

      expect(result.uri, testVideo.uri);
    });

    test("- insert Link", () {
      var result = testRunnerPut<LinkObjectBox>(testLink);

      expect(result.uri, testVideo.uri);
    });

    test("- insert Link", () {
      var result = testRunnerPut<ImageObjectBox>(testImage);

      expect(result.uri, testVideo.uri);
    });

    test("- insert Post", () {
      var result = testRunnerPut<PostObjectBox>(testPost);

      expect(result.raw, testVideo.raw);
    });
  });
}
