import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/drift_config.dart';

import 'package:waultar/startup.dart';

Future<void> main() async {
  late WaultarDb db;
  await setupServices(testing: true);

  setUpAll(() {
    db = locator<WaultarDb>();
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Test that profile DAO invoked correct', () {
    test('given empty db returns no profile', () async {
      IProfileRepository _dao = db.profileDao;

      final profiles = await _dao.getAllProfiles();
      expect(profiles.isEmpty, true);

      // final created = await dao.getTodoByIdAsFuture(1);
      // expect(created.title, 'Setup drift');
    });

    test('given new profile returns id 1', () async {
      IProfileRepository _dao = db.profileDao;
      var model = ProfileModel(null, 'test_username', 'test_user', 'user@mail.com', 'male', 'he/she', '12345678', DateTime.now(), 'link', 'json');

      int id = await _dao.addProfile(model);
      expect(id, 1);

      final createdProfile = await _dao.getProfileById(1);
      expect(createdProfile.name, 'test_user');
    });
  });
}
