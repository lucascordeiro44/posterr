import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';

abstract class ICreateRepostUsecase {
  Future<Either<Failure, bool>> call(Post post);
}

class CreateRepostUsecase implements ICreateRepostUsecase {
  IPostsRepository repository;
  CreateRepostUsecase(this.repository);
  @override
  Future<Either<Failure, bool>> call(Post post) {
    return repository.createRepost(post);
  }
}
