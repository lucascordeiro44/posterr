import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/datasources/post.datasource.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';

class PostRepositoryImpl implements IPostsRepository {
  IPostDatasource datasource;

  PostRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final result = await datasource.getPosts();
      return right(result);
    } catch (e) {
      return left(PostFailure(message: e.toString()));
    }
  }
}
