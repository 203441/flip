import '../entities/post.dart';

abstract class PostRepository {
  Stream<List<Post>> getPosts();
  Future<Post> uploadPost(String description, String filePath);
}
