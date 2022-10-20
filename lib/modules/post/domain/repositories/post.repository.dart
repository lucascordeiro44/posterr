import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

abstract class IPostsRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, bool>> createPost(Post post);
}
