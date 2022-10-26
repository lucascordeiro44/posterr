import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/user_profile/data/repositories/user_profile.repository_impl.dart';

import '../../../../mocks.dart';

final mockUserDatasource = MockUserDatasource();

late UserProfileRepositoryImpl repository;

void main() {
  setUpAll(() {
    repository = UserProfileRepositoryImpl(datasource: mockUserDatasource);
  });

  group('should test setUsers to save local data from user_profile repository',
      () {
    test(
        'should create Users data locally when the call to save local data source is success',
        () async {
      //arrenge
      when(() => mockUserDatasource.setUsers(any()))
          .thenAnswer((_) async => true);

      //act
      final result = await repository.setUsers(users);
      //assert
      expect(result, equals(const Right(true)));
    });
  });

  group(
      'should test getUser to get current user locally from user_profile repository',
      () {
    test('Should test GetUser from user_profile repository', () async {
      //arrenge
      when(() => mockUserDatasource.getUser(any()))
          .thenAnswer((_) async => user);
      //act
      final result = await repository.getCurrentUser(user.username);
      //assert
      expect(result, equals(Right(user)));
    });
  });

  group('should test get all Users from user_profile repository', () {
    test('Should test GetUsers from user_profile repository', () async {
      //arrenge
      when(() => mockUserDatasource.getUsers()).thenAnswer((_) async => users);
      //act
      final result = await repository.getUsers();
      //assert
      expect(result, equals(Right(users)));
    });
  });
}
