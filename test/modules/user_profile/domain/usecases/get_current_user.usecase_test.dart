import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/core/error/formats.dart' as format;
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';


class MockUserProfileRepository extends Mock implements IUserProfileRepository {}

final mockUserProfileRepository = MockUserProfileRepository();

void main() {

  final user = User(username: 'Lucas Cordeiro', joinedDate: DateTime.now());

  group('Get Current User Usecase Test', () {
    test('GetCurrentUserUseCase should return current User ', () async {

      //arrenge
      when(() => mockUserProfileRepository.getCurrentUser())
          .thenAnswer((_) async => Right(user));
      final usecase = GetCurrentUserUsecase(mockUserProfileRepository);

      //act
      final result = await usecase.call();

      //assert
      expect(result, Right(user));
      
    });
    test('Test if formatDate is correct', () async {
      final date = user.dateJoined;
      expect(date,  format.formatDate(DateTime.now()));
  });
  });

}