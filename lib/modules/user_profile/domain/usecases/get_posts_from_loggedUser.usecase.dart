import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

abstract class IGetPostsFromLoggedUserUsecase {
  Future<Either<Failure, List<Post>>> call(User user);
}

class GetPostsFromLoggedUserUsecase extends IGetPostsFromLoggedUserUsecase {
  final IUserProfileRepository repository;
  GetPostsFromLoggedUserUsecase(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(User user) {
    return repository.getPostsFromLoggedUser(user);
  }
}
