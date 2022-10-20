import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class IUserProfileRepository {
  Future<Either<Failure, User>> getCurrentUser(String key);
  Future<Either<Failure, bool>> setUsers(List<User> users);
  Future<Either<Failure, List<User>>> getUsers();
}
