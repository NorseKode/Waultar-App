
import 'package:waultar/core/models/content/post_model.dart';

abstract class IPostRepository {
  Stream<PostModel> watchAllPosts();
  Stream<PostModel> watchFacebookPosts();
  Stream<PostModel> watchInstagramPosts();
  PostModel getAllPosts();
  PostModel getAllPostsPagination(int offset, int limit);
  PostModel getSinglePost(int id);
  void addPost(PostModel post);
  Future addPostAsync(PostModel post);
}