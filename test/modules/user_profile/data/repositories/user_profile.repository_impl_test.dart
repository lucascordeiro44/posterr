import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/data/repositories/user_profile.repository_impl.dart';

import '../../../../mocks.dart';

final mockUserDatasource = MockUserDatasource();

void main() {
  group('should test setUsers to save local data from user_profile repository',
      () async {
    test(
        'should create Users data locally when the call to save local data source is success',
        () async {
      //arrenge
      when(() => mockUserDatasource.setUsers(any()))
          .thenAnswer((_) async => true);
      final repository =
          UserProfileRepositoryImpl(datasource: mockUserDatasource);
      //act
      final result = await repository.setUsers(users);
      //assert
      expect(result, equals(Right(users)));
    });

    test(
        'should return setUser failure when the call to save local data source is unsuccessful',
        () async {
      //arrenge
      when(() => mockUserDatasource.setUsers(any())).thenThrow(
          (_) => throw SetUserException(message: 'Failed to create users'));
      final repository =
          UserProfileRepositoryImpl(datasource: mockUserDatasource);
      //act
      final result = await repository.setUsers(users);
      //assert
      expect(result,
          equals(left(SetUserException(message: 'Failed to create users'))));
    });
  });

  group(
      'should test getUser to get current user locally from user_profile repository',
      () async {
    test('Should test GetUser from user_profile repository', () async {
      //arrenge
      when(() => mockUserDatasource.getUser(any()))
          .thenAnswer((_) async => user);
      final repository =
          UserProfileRepositoryImpl(datasource: mockUserDatasource);
      //act
      final result = await repository.getCurrentUser(user.username);
      //assert
      expect(result, equals(Right(user)));
    });

    test(
        'should return getUser failure when the call to get user locally data source is unsuccessful',
        () async {
      //arrenge
      when(() => mockUserDatasource.getUser(any()))
          .thenThrow(GetUserException(message: 'Failed to get user'));
      final repository =
          UserProfileRepositoryImpl(datasource: mockUserDatasource);
      //act
      final result = await repository.getCurrentUser(user.username);
      //assert
      expect(result,
          equals(Left(GetUserException(message: 'Failed to get user'))));
    });
  });

  group('should test get all Users from user_profile repository', () async {
    test('Should test GetUsers from user_profile repository', () async {
      //arrenge
      when(() => mockUserDatasource.getUsers()).thenAnswer((_) async => users);
      final repository =
          UserProfileRepositoryImpl(datasource: mockUserDatasource);
      //act
      final result = await repository.getUsers();
      //assert
      expect(result, equals(Right(users)));
    });

    test(
        'should return getUser failure when the call to get all users locally in the datasource fails',
        () async {
      //arrenge
      when(() => mockUserDatasource.getUsers())
          .thenThrow(GetUserException(message: 'Failed to get all users'));
      final repository =
          UserProfileRepositoryImpl(datasource: mockUserDatasource);
      //act
      final result = await repository.getUsers();
      //assert
      expect(result,
          equals(Left(GetUserException(message: 'Failed to get all users'))));
    });
  });
}
