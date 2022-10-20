import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_users.usecase.dart';

import '../../../../mocks.dart';

final MockUserProfileRepository mockUserProfileRepository =
    MockUserProfileRepository();

void main() {
  group('Get Users Usecase Test', () async {
    test('Should return all users in the Hive database', () async {});
    //arrenge
    when(() => mockUserProfileRepository.getUsers())
        .thenAnswer((_) async => Right(users));
    final usecase = GetUsersUsecase(mockUserProfileRepository);
    //act
    final result = await usecase.call();

    //assert
    expect(result, equals(Right(users)));
  });
}
