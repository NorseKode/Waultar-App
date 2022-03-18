import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';

abstract class IPostRepository {
  Stream<PostModel>? watchAllPosts();
  Stream<PostModel>? watchFacebookPosts();
  Stream<PostModel>? watchInstagramPosts();
  List<PostModel>? getAllPosts();
  List<PostModel>? getAllPostsPagination(int offset, int limit);
  PostModel? getSinglePost(int id);
  int addPost(PostModel post);
  Future<int> addPostAsync(PostModel post);
  int removeAllPosts();
  List<PostModel> search(String search, int offset, int limit);
  List<PostObjectBox> getAllPostsAsEntity();
}
