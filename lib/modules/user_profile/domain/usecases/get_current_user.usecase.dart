import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

abstract class IGetCurrentUserUsecase {
  Future<Either<UserException, User>> call(String key);
}

class GetCurrentUserUsecase implements IGetCurrentUserUsecase {
  final IUserProfileRepository repository;
  GetCurrentUserUsecase(this.repository);

  @override
  Future<Either<UserException, User>> call(String key) async {
    return repository.getCurrentUser(key);
  }
}
