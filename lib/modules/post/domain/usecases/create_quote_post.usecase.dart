import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';

abstract class ICreateQuotePostUsecase {
  Future<Either<Failure, bool>> call(Post post, String comment);
}

class CreateQuotePostUsecase implements ICreateQuotePostUsecase {
  IPostsRepository repository;
  CreateQuotePostUsecase(this.repository);
  @override
  Future<Either<Failure, bool>> call(Post post, String comment) {
    return repository.createQuotePost(post, comment);
  }
}
