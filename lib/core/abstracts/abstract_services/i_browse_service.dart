import 'package:waultar/core/models/content/group_model.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

abstract class IBrowseService {
  ProfileModel? chosenProfile;

  List<ProfileModel> getProfiles();
  List<PostModel> getPosts();
  List<GroupModel> getGroups();
}
