import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class IUserProfileRepository {
  Future<Either<UserException, User>> getCurrentUser(String key);
  Future<Either<UserException, bool>> setUsers(List<User> users);
}
