import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import '../repositories/user_profile.repository.dart';

abstract class ISetUsersUsecase {
  Future<Either<UserException, int>> call();
}

class GetCurrentUserUsecase implements ISetUsersUsecase {
  final IUserProfileRepository repository;
  GetCurrentUserUsecase(this.repository);

  @override
  Future<Either<UserException, int>> call() async {
    return repository.setUsers();
  }
}