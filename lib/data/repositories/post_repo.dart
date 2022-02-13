import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class PostRepository implements IPostRepository {
  late final ObjectBox _context;
  late final Box<PostObjectBox> _postBox;
  late final IObjectBoxDirector _director;

  PostRepository(this._context, this._director) {
    _postBox = _context.store.box<PostObjectBox>();
  }

  @override
  void addPost(PostModel post) {
    var entity = _director.make<PostObjectBox>(post);
    _postBox.put(entity);
  }

  @override
  // TODO : putAsync does not work if toMany relations has not been set ..
  Future addPostAsync(PostModel post) async {
    var entity = _director.make<PostObjectBox>(post);
    await _postBox.putAsync(entity);
  }

  @override
  PostModel getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  PostModel getAllPostsPagination(int offset, int limit) {
    // TODO: implement getAllPostsPagination
    throw UnimplementedError();
  }

  @override
  PostModel getSinglePost(int id) {
    var post = _postBox.get(id)!;
    var profile = post.profile.target!;
    var service = profile.service.target!;
    var serviceModel = ServiceModel(service.id, service.name, service.company, Uri(path: service.image));
    var profileModel = ProfileModel(service: serviceModel, uri: Uri(path: profile.uri), fullName: profile.fullName, emails: [], createdTimestamp: profile.createdTimestamp, activities: [], raw: profile.raw); 
    PostModel postModel = PostModel(id: post.id, profile: profileModel, raw: post.raw, timestamp: post.timestamp);

    return postModel;
  }

  @override
  Stream<PostModel> watchAllPosts() {
    // TODO: implement watchAllPosts
    throw UnimplementedError();
  }

  @override
  Stream<PostModel> watchFacebookPosts() {
    // TODO: implement watchFacebookPosts
    throw UnimplementedError();
  }

  @override
  Stream<PostModel> watchInstagramPosts() {
    // TODO: implement watchInstagramPosts
    throw UnimplementedError();
  }
}
