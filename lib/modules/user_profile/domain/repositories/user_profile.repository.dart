import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class IUserProfileRepository {
  Future<Either<Failure, User>> getCurrentUser(String key);
  Future<Either<Failure, bool>> setUsers(List<User> users);
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, List<ContentItem>>> getUserContents(User user);
}
