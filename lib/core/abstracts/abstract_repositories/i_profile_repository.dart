import 'package:waultar/core/models/index.dart';

abstract class IProfileRepository {
  int addProfile(ProfileModel profile);
  ProfileModel getProfileById(int id);
  List<ProfileModel> getAllProfiles();
}
