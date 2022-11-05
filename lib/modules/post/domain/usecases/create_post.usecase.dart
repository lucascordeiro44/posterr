import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';

abstract class ICreatePostUsecase {
  Future<Either<Failure, bool>> call(String title, String text);
}

class CreatePostUsecase implements ICreatePostUsecase {
  final IPostsRepository repository;

  CreatePostUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String title, String text) async {
    return await repository.createPost(title, text);
  }
}
