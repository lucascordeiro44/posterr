import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';

abstract class IGetHomeContentUsecase {
  Future<Either<Failure, List<ContentItem>>> call();
}

class GetHomeContentUsecase extends IGetHomeContentUsecase {
  final IPostsRepository repository;

  GetHomeContentUsecase(this.repository);

  @override
  Future<Either<Failure, List<ContentItem>>> call() {
    return repository.getAllHomeContent();
  }
}
