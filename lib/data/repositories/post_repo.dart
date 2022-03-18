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
  int addPost(PostModel post) {
    var entity = _entityDirector.make<PostObjectBox>(post);
    int id = _postBox.put(entity);
    return id;
  }

  @override
  // TODO : putAsync does not work if toMany relations has not been set ..
  Future<int> addPostAsync(PostModel post) async {
    var entity = _entityDirector.make<PostObjectBox>(post);
    int id = await _postBox.putAsync(entity);
    return id;
  }

  @override
  List<PostModel>? getAllPosts() {
    var postEntities = _postBox.getAll();
    if (postEntities.isNotEmpty) {
      return _postBox
          .getAll()
          .map((e) => _modelDirector.make<PostModel>(e))
          .toList();
    } else {
      return null;
    }
  }

  @override
  List<PostModel>? getAllPostsPagination(int offset, int limit) {
    var queryBuilder = _postBox.query();
    queryBuilder.order(PostObjectBox_.timestamp);
    final query = queryBuilder.build();
    query
      ..offset = offset
      ..limit = limit;

    var result = query.find();
    return result.map((p) => _modelDirector.make<PostModel>(p)).toList();
  }

  @override
  PostModel? getSinglePost(int id) {
    var postEntity = _postBox.get(id);

    if (postEntity != null) {
      var postModel = _modelDirector.make<PostModel>(postEntity);
      return postModel;
    } else {
      return null;
    }
  }

  @override
  Stream<PostModel>? watchAllPosts() {
    // TODO: implement watchAllPosts
    throw UnimplementedError();
  }

  @override
  Stream<PostModel>? watchFacebookPosts() {
    // TODO: implement watchFacebookPosts
    throw UnimplementedError();
  }

  @override
  Stream<PostModel>? watchInstagramPosts() {
    // TODO: implement watchInstagramPosts
    throw UnimplementedError();
  }

  @override
  int removeAllPosts() {
    return _postBox.removeAll();
  }

  @override
  List<PostModel> search(String search, int offset, int limit) {
    var build =
        _postBox.query(PostObjectBox_.textSearch.contains(search)).build();

    build
      ..offset = offset
      ..limit = limit;

    return build
        .find()
        .map((entity) => _modelDirector.make<PostModel>(entity))
        .toList();
  }

  @override
  List<PostObjectBox> getAllPostsAsEntity() {
    return _postBox.getAll();
  }
}
