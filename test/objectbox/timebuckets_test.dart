// import 'package:flutter_test/flutter_test.dart';
// import 'package:waultar/core/abstracts/abstract_repositories/i_event_repository.dart';
// import 'package:waultar/core/abstracts/abstract_repositories/i_group_repository.dart';
// import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
// import 'package:waultar/core/abstracts/abstract_repositories/i_timebuckets_repository.dart';
// import 'package:waultar/core/models/content/post_model.dart';
// import 'package:waultar/core/models/model_helper.dart';
// import 'package:waultar/core/models/profile/profile_model.dart';
// import 'package:waultar/core/models/timeline/time_models.dart';
// import 'package:waultar/data/configs/objectbox.g.dart';
// import 'package:waultar/data/entities/misc/service_objectbox.dart';
// import 'package:waultar/data/entities/profile/profile_objectbox.dart';
// import 'package:waultar/data/repositories/appsettings_repo.dart';
// import 'package:waultar/data/repositories/event_repo.dart';
// import 'package:waultar/data/repositories/group_repo.dart';
// import 'package:waultar/data/repositories/model_builders/model_director.dart';
// import 'package:waultar/data/repositories/objectbox_builders/objectbox_director.dart';
// import 'package:waultar/data/repositories/post_repo.dart';
// import 'package:waultar/data/repositories/timebuckets_repo.dart';
// import 'package:waultar/domain/services/time_buckets_creator.dart';

// import 'setup.dart';

// Future<void> main() async {
//   late ITimeBucketsRepository _timeRepo;
//   late IPostRepository _postRepo;
//   late IGroupRepository _groupRepo;
//   late IEventRepository _eventRepo;
//   late TimeBucketsCreator _creator;
//   late ObjectBoxMock _context;
//   late final ProfileModel profileModel;

//   var testProfile = ProfileObjectBox(
//       uri: "test/path",
//       fullName: "John Doe",
//       createdTimestamp: DateTime.now(),
//       raw: "raw");

//   T testRunnerPut<T>(T testEntity) {
//     var box = _context.store.box<T>();

//     var id = box.put(testEntity);

//     return box.get(id)!;
//   }

//   // timestamps to test with :
//   /* 
//     1615810187 -> Mon Mar 15 2021 12:09:47 GMT+0000
//     1615723787 -> Sun Mar 14 2021 12:09:47 GMT+0000
//     1618916987 -> Tue Apr 20 2021 11:09:47 GMT+0000
//     1587380987 -> Mon Apr 20 2020 11:09:47 GMT+0000
//   */

//   setUpAll(() async {
//     await deleteTestDb();
//     _context = await ObjectBoxMock.create();
//     final _modelDirector = ModelDirector();
//     final _entityDirector = ObjectBoxDirector(_context);
//     _timeRepo = TimeBucketsRepository(_context);
//     _postRepo = PostRepository(_context, _entityDirector, _modelDirector);
//     _groupRepo = GroupRepository(_context, _entityDirector, _modelDirector);
//     _eventRepo = EventRepository(_context, _entityDirector, _modelDirector);

//     _creator = TimeBucketsCreator();

//     var service = _context.store
//         .box<ServiceObjectBox>()
//         .query(ServiceObjectBox_.name.equals("Facebook"))
//         .build()
//         .findFirst()!;
//     testProfile.service.target = service;
//     var profile = testRunnerPut<ProfileObjectBox>(testProfile);
//     profileModel = _modelDirector.make<ProfileModel>(profile);

//     var post1 = PostModel(
//         profile: profileModel,
//         raw: "",
//         timestamp: ModelHelper.intToTimestamp(1615810187)!);

//     var post2 = PostModel(
//         profile: profileModel,
//         raw: "",
//         timestamp: ModelHelper.intToTimestamp(1615723787)!);

//     var post3 = PostModel(
//         profile: profileModel,
//         raw: "",
//         timestamp: ModelHelper.intToTimestamp(1618916987)!);

//     var post4 = PostModel(
//         profile: profileModel,
//         raw: "",
//         timestamp: ModelHelper.intToTimestamp(1587380987)!);

//     _postRepo.addPost(post2);
//     _postRepo.addPost(post3);
//     _postRepo.addPost(post4);
//     _postRepo.addPost(post1);
//   });

//   tearDownAll(() async {
//     _context.store.close();
//     await deleteTestDb();
//   });

//   group('Test timebuckets creation', () {
//     test(' - posts', () async {
//       _creator.createTimeBuckets();
//       var yearResult = _timeRepo.getAllYears();
//       expect(yearResult.length, 2);
//       expect(yearResult.first.entries.length, 1);
//       expect(yearResult.first.timeValue, 2020);
//       expect(yearResult.first.total, 1);
//       expect(yearResult.last.total, 3);
//       expect(yearResult.last.timeValue, 2021);
//       expect(yearResult.last.entries.length, 1);

//       var months = _timeRepo.getAllMonthsFromYear(yearResult.last);
//       expect(months.length, 2);
//       expect(months.first.timeValue, 3);
//       expect(months.last.timeValue, 4);

//       var days = _timeRepo.getAllDaysFromMonth(months.first);
//       expect(days.length, 2);
//     });
//   });
// }
