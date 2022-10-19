import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/user_profile/data/repositories/user_profile.repository_impl.dart';

import '../../../../mocks.dart';

final mockUserDatasource = MockUserDatasource();

void main() {
  test('Should test SetUsers from user_profile repository', () async {
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

  test('Should test GetUser from user_profile repository', () async {
    //arrenge
    when(() => mockUserDatasource.getUser(any())).thenAnswer((_) async => user);
    final repository =
        UserProfileRepositoryImpl(datasource: mockUserDatasource);
    //act
    final result = await repository.getCurrentUser(user.username);
    //assert
    expect(result, equals(Right(user)));
  });

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
}
