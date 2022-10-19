import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

import '../../../../mocks.dart';

class MockHive extends Mock implements Box<User> {}

final mockBox = MockHive();

void main() {
  group('Should Test GetUser', () async {
    test('Should test GetUser in user datasource', () async {
      when(() => mockBox.get(any())).thenReturn(user);
      final datasource = UserDatasource(box: mockBox);
      //act
      final result = await datasource.getUser(user.username);
      //assert
      expect(result, equals(user));
    });

    test('should throw a UserException when there is a not valid User',
        () async {
      when(() => mockBox.get(any())).thenThrow(Exception());
      final datasource = UserDatasource(box: mockBox);
      //act
      await datasource.getUser(user.username);
      //assert
      expect(() async => await datasource.getUser(user.username),
          throwsA(isA<UserException>()));
    });
  });

  group('Should Test setUsers', () async {
    test('Should test setUsers in user datasource succesfull', () async {
      when(() => mockBox.putAll(any())).thenAnswer((_) async => true);
      final datasource = UserDatasource(box: mockBox);
      //act
      final result = await datasource.setUsers(users);
      //assert
      expect(result, equals(users));
    });

    test(
        'Should throw a UserException when an error occurs while adding the users',
        () async {
      when(() => mockBox.putAll(any())).thenThrow(Exception());
      final datasource = UserDatasource(box: mockBox);
      //act
      await datasource.setUsers(users);
      //assert
      expect(() async => await datasource.setUsers(users),
          throwsA(isA<UserException>()));
    });
  });
}
