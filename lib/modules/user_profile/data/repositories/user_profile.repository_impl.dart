import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

class UserProfileRepositoryImpl implements IUserProfileRepository {
  final IUserDatasource datasource;

  UserProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<UserException, User>> getCurrentUser(String key) async {
    try {
      final user = await datasource.getUser(key);
      return right(user);
    } catch (e) {
      return left(UserException(message: e.toString()));
    }
  }

  @override
  Future<Either<UserException, List<User>>> getUsers() async {
    try {
      final List<User> user = await datasource.getUsers();
      return right(user);
    } catch (e) {
      return left(UserException(message: e.toString()));
    }
  }

  @override
  Future<Either<UserException, bool>> setUsers(List<User> users) async {
    try {
      final result = await datasource.setUsers(users);
      return right(result);
    } catch (e) {
      return left(UserException(message: e.toString()));
    }
  }
}
