import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post_model.dart';
import '../datasources/post_datasource.dart';

class PostRepositoryImp implements PostRepository {
  final PostDataSource dataSource;

  PostRepositoryImp(this.dataSource);

  @override
  Stream<List<Post>> getPosts() {
    return dataSource.getPosts().map((postModels) =>
        postModels.map((postModel) => postModel.toDomain()).toList());
  }

  @override
  Future<Post> uploadPost(String description, String filePath) async {
    final postModel = await dataSource.uploadPost(description, filePath);
    return postModel.toDomain();
  }
}
