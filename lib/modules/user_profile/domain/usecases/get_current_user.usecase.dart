import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

abstract class IGetCurrentUserUsecase {
  Future<Either<GetUserException, User>> call();
}

class GetCurrentUserUsecase implements IGetCurrentUserUsecase {
  final IUserProfileRepository repository;
  GetCurrentUserUsecase(this.repository);

  @override
  Future<Either<GetUserException, User>> call() async {
    return repository.getCurrentUser();
  }
}
