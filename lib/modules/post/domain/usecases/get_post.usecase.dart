import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

import '../repositories/post.repository.dart';

abstract class IGetPostsUsecase {
  Future<Either<Failure, Post>> call(int postId);
}

class GetPostsUsecase implements IGetPostsUsecase {
  IPostsRepository repository;

  GetPostsUsecase(this.repository);

  @override
  Future<Either<Failure, Post>> call(int postId) {
    return repository.getPost(postId);
  }
}
