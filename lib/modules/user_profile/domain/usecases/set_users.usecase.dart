import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import '../repositories/user_profile.repository.dart';

abstract class ISetUsersUsecase {
  Future<Either<Failure, bool>> call(List<User> user);
}

class SetUsersUsecase implements ISetUsersUsecase {
  final IUserProfileRepository repository;
  SetUsersUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(List<User> users) async {
    return await repository.setUsers(users);
  }
}
