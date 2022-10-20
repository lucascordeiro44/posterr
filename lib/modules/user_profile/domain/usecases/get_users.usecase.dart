import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

abstract class IGetUsersUsecase {
  Future<Either<Failure, List<User>>> call();
}

class GetUsersUsecase implements IGetUsersUsecase {
  final IUserProfileRepository repository;
  GetUsersUsecase(this.repository);

  @override
  Future<Either<Failure, List<User>>> call() async {
    return repository.getUsers();
  }
}
