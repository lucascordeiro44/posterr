import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

abstract class IPostsRepository {
  Future<Either<Failure, Post>> getPost(int postId);
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, bool>> createPost(String text);
  // Future<Either<Failure, bool>> createRepost(int postId);
}
