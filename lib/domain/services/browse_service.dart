import 'package:waultar/core/abstracts/abstract_repositories/i_post_poll_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_profile_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_browse_service.dart';
import 'package:waultar/core/models/content/group_model.dart';
import 'package:waultar/core/models/content/post_poll_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/startup.dart';

class BrowseService extends IBrowseService {
  ProfileModel? chosenProfile;
  final IProfileRepository _profileRepo =
      locator.get<IProfileRepository>(instanceName: 'profileRepo');
  final IPostRepository _postRepo =
      locator.get<IPostRepository>(instanceName: 'postRepo');
  // final IPostRepository _groupRepo =
  //     locator.get<IPostRepository>(instanceName: 'postRepo');
  final IPostPollRepository _postPollRepo =
      locator.get<IPostPollRepository>(instanceName: 'postPollRepo');

  @override
  List<PostModel>? getPosts() {
    return _postRepo.getAllPosts();
  }

  @override
  List<ProfileModel> getProfiles() {
    return _profileRepo.getAllProfiles();
  }

  @override
  List<GroupModel> getGroups() {
    // TODO: implement getGroups
    throw UnimplementedError();
    // return _groupRepo.getAllGroups();
  }

  @override
  List<PostPollModel> getPostPolls() {
    return _postPollRepo.getAllPostPolls();
  }
}
