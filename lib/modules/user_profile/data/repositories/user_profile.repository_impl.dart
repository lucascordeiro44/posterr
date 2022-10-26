import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

class UserProfileRepositoryImpl implements IUserProfileRepository {
  final IUserDatasource datasource;

  UserProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, User>> getCurrentUser(String key) async {
    try {
      final user = await datasource.getUser(key);
      return right(user);
    } on UserException catch (e, s) {
      return left(GetUserException(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final List<User> user = await datasource.getUsers();
      return right(user);
    } on UserException catch (e, s) {
      return left(GetUserException(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, bool>> setUsers(List<User> users) async {
    try {
      final result = await datasource.setUsers(users);
      return right(result);
    } on UserException catch (e, s) {
      return left(SetUserException(message: e.message, stackTrace: s));
    }
  }
}
