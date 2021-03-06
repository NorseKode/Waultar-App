import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/startup.dart';

class ProfileRepository {
  final ObjectBox _context;
  late final Box<ProfileDocument> _profileBox;
  final BaseLogger _logger = locator.get<BaseLogger>(instanceName: 'logger');

  ProfileRepository(this._context) {
    _profileBox = _context.store.box<ProfileDocument>();
  }

  ProfileDocument add(ProfileDocument model) {
    var id = _profileBox.put(model);
    var profile = _profileBox.get(id);

    if (profile == null) {
      throw "Null profile";
    }

    _logger.logger.info(profile.name);
    return profile;
  }

  ProfileDocument? get(int id) {
    return _profileBox.get(id);
  }

  List<ProfileDocument> getAll() {
    return _profileBox.getAll();
  }
}
