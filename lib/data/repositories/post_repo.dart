import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class PostRepository implements IPostRepository {
  late final ObjectBox _context;
  late final Box<PostObjectBox> _postBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;

  PostRepository(this._context, this._entityDirector, this._modelDirector) {
    _postBox = _context.store.box<PostObjectBox>();
  }

  @override
  void addPost(PostModel post) {
    var entity = _entityDirector.make<PostObjectBox>(post);
    _postBox.put(entity);
  }

  @override
  // TODO : putAsync does not work if toMany relations has not been set ..
  Future addPostAsync(PostModel post) async {
    var entity = _entityDirector.make<PostObjectBox>(post);
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
    var postEntity = _postBox.get(id)!;
    var postModel = _modelDirector.make<PostModel>(postEntity);

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
