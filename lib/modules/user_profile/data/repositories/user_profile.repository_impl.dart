import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

class UserProfileRepositoryImpl implements IUserProfileRepository {
  @override
  Future<Either<GetUserException, User>> getCurrentUser() {
    throw UnimplementedError();
  }
}