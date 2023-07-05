import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Stream<List<Post>> call() {
    return repository.getPosts();
  }
}

class UploadPostUseCase {
  final PostRepository repository;

  UploadPostUseCase(this.repository);

  Future<Post> call(String description, String filePath) {
    return repository.uploadPost(description, filePath);
  }
}
