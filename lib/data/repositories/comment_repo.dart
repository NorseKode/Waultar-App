import 'package:waultar/core/abstracts/abstract_repositories/i_comment_repository.dart';
import 'package:waultar/core/models/content/comment_model.dart';
import 'package:waultar/core/models/media/image_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/comment_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class CommentRepository extends ICommentRepository {
  late final ObjectBox _context;
  late final Box<CommentObjectBox> _commentBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;

  CommentRepository(this._context, this._entityDirector, this._modelDirector) {
    _commentBox = _context.store.box<CommentObjectBox>();
  }

  @override
  int add(CommentModel model) {
    return _commentBox.put(_entityDirector.make<CommentObjectBox>(model));
  }

  @override
  bool delete(int id) {
    return _commentBox.remove(id);
  }

  @override
  int deleteAll() {
    return _commentBox.removeAll();
  }

  @override
  CommentModel get(int id) {
    return _modelDirector.make<CommentModel>(_commentBox.get(id));
  }

  @override
  List<CommentModel> getAll() {
    return _commentBox.getAll().map((e) => _modelDirector.make<CommentModel>(e)).toList();
  }

  @override
  List<CommentModel> getAllPagination(int offset, int limit) {
    var queryBuilder = _commentBox.query();
    queryBuilder.order(CommentObjectBox_.timestamp);

    final query = queryBuilder.build()
      ..offset = offset
      ..limit = limit;

    return query.find()
      .map((e) => _modelDirector.make<CommentModel>(e)).toList();
  }

  @override
  CommentModel update(int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  List<CommentModel> search(String search, int offset, int limit) {
    var build = _commentBox.query(CommentObjectBox_.textSearch.contains(search)).build();

    build
      ..offset = offset
      ..limit = limit;

    return build.find().map((entity) => _modelDirector.make<CommentModel>(entity)).toList();
  }
}
