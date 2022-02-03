import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/drift_config.dart';

import 'package:waultar/startup.dart';

Future<void> main() async {
  late WaultarDb db;
  late IProfileRepository _repo;
  await setupServices(testing: true);

  setUpAll(() {
    db = locator<WaultarDb>();
    _repo = db.profileDao;
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Test that profile DAO invoked correct', () {
    test('given empty db returns no profile', () async {
      final profiles = await _repo.getAllProfiles();
      expect(profiles.isEmpty, true);
    });

    test('given new profile returns id 1', () async {
      var model = ProfileModel(null, 'test_username', 'test_user', 'user@mail.com', 'male', 'he/she', '12345678', DateTime.now(), 'link', 'json');

      int id = await _repo.addProfile(model);
      expect(id, 1);

      final createdProfile = await _repo.getProfileById(1);
      expect(createdProfile.name, 'test_user');
    });
  });
}
