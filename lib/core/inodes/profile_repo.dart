import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class ProfileRepository {
  final ObjectBox _context;
  late final Box<ProfileDocument> _profileBox;

  ProfileRepository(this._context) {
    _profileBox = _context.store.box<ProfileDocument>();
  }

  ProfileDocument add(ProfileDocument model) {
    var id = _profileBox.put(model);
    var profile = _profileBox.get(id);

    if (profile == null) {
      throw "Null profile";
    }

    return profile;
  }
}