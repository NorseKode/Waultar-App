import 'package:waultar/core/models/index.dart';

abstract class ICommentRepository {
  int add(CommentModel model);
  CommentModel get(int id);
  List<CommentModel> getAll();
  List<CommentModel> getAllPagination(int offset, int limit);
  bool delete(int id);
  int deleteAll();
  CommentModel update(int id);
  List<CommentModel> search(String search, int offset, int limit);
}
