import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/core/error/formats.dart' as format;
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';

import '../../../../mocks.dart';

final mockUserProfileRepository = MockUserProfileRepository();

void main() {
  group('Get Current User Usecase Test', () {
    test('GetCurrentUserUseCase should return current User ', () async {
      //arrenge
      when(() => mockUserProfileRepository.getCurrentUser(any()))
          .thenAnswer((_) async => Right(user));
      final usecase = GetCurrentUserUsecase(mockUserProfileRepository);

      //act
      final result = await usecase.call(user.username);

      //assert
      expect(result, Right(user));
    });
    test('Test if formatDate is correct', () async {
      const formatDate = 'October 18, 2022';
      final date = user.dateJoined;
      expect(date, equals(formatDate));
    });
  });
}
