import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

abstract class IGetUserContentsUsecase {
  Future<Either<Failure, List<ContentItem>>> call(User user);
}

class GetUserContentsUsecase extends IGetUserContentsUsecase {
  final IUserProfileRepository repository;
  GetUserContentsUsecase(this.repository);

  @override
  Future<Either<Failure, List<ContentItem>>> call(User user) async {
    // await Future.delayed(const Duration(seconds: 2));
    return repository.getUserContents(user);
  }
}
