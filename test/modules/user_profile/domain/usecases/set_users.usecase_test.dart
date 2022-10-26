import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/user_profile/domain/usecases/set_users.usecase.dart';

import '../../../../mocks.dart';

final mockUserProfileRepository = MockUserProfileRepository();
void main() {
  group('Set Users Usecase test', () {
    test('Should create 4 users when called', () async {
      //arrange
      when(() => mockUserProfileRepository.setUsers(any()))
          .thenAnswer((_) async => const Right(true));
      final usecase = SetUsersUsecase(mockUserProfileRepository);
      //act
      final result = await usecase.call(users);
      //assert
      expect(result, const Right(true));
    });
  });
}
