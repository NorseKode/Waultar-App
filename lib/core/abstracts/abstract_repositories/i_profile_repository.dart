
import 'package:waultar/core/models/profile_model.dart';

abstract class IProfileRepository {
  Future<int> addProfile(ProfileModel profile);
  Future<ProfileModel> getProfileById(int id);
  Future<List<ProfileModel>> getAllProfiles();
}