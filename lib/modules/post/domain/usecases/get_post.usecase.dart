import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

import '../repositories/post.repository.dart';

abstract class IGetPostUsecase {
  Future<Either<Failure, Post>> call(int postId);
}

class GetPostUsecase implements IGetPostUsecase {
  IPostsRepository repository;

  GetPostUsecase(this.repository);

  @override
  Future<Either<Failure, Post>> call(int postId) {
    return repository.getPost(postId);
  }
}
