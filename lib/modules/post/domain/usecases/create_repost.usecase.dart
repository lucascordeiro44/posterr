import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';

abstract class ICreateRePostUsecase {
  Future<Either<Failure, bool>> call(int postId);
}

class CreatePostUsecase implements ICreateRePostUsecase {
  final IPostsRepository repository;

  CreatePostUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(int postId) async {
    return await repository.createRepost(postId);
  }
}
