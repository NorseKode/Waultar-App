import 'package:waultar/core/abstracts/abstract_repositories/i_post_poll_repository.dart';
import 'package:waultar/core/models/content/post_poll_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/post_poll_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class PostPollRepository implements IPostPollRepository {
  late final ObjectBox _context;
  late final Box<PostPollObjectBox> _postPollBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;

  PostPollRepository(this._context, this._entityDirector, this._modelDirector) {
    _postPollBox = _context.store.box<PostPollObjectBox>();
  }

  @override
  int addPostPoll(PostPollModel model) {
    return _postPollBox.put(_entityDirector.make<PostPollObjectBox>(model));
  }

  @override
  Future<int> addPostPollAsync(PostPollModel model) async {
    var entity = _entityDirector.make<PostPollObjectBox>(model);
    int id = await _postPollBox.putAsync(entity);
    return id;
  }

  @override
  List<PostPollModel> getAllPostPolls() {
    var postPollModels = <PostPollModel>[];
    
    for (var postPoll in _postPollBox.getAll()) {
      postPollModels.add(_modelDirector.make<PostPollModel>(postPoll));
    }

    return postPollModels;
  }

  @override
  int removeAll() {
    return _postPollBox.removeAll();
  }
}
