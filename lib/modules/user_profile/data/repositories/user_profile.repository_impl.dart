import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

class UserProfileRepositoryImpl implements IUserProfileRepository {
  final IUserDatasource datasource;

  UserProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<GetUserException, User>> getCurrentUser() async {
    try {
       final user = await datasource.getUser();
       return right(user);
    } catch (e){
      return left(GetUserException(message: e.toString()));
    }
  }
}