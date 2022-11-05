import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

import '../../../../mocks.dart';

class MockHive extends Mock implements Box<User> {}

class PostMockHive extends Mock implements Box<Post> {}

final mockBox = MockHive();

final mockPost = PostMockHive();

void main() {
  group('Should Test GetUser', () {
    test('Should test GetUser in user datasource', () async {
      when(() => mockBox.get(any())).thenReturn(user);
      final datasource = UserDatasource(usersBox: mockBox, postsBox: mockPost);
      //act
      final result = await datasource.getUser(user.username);
      //assert
      expect(result, equals(user));
    });
  });

  group('Should Test setUsers', () {
    test('Should test setUsers in user datasource succesfull', () async {
      when(() => mockBox.putAll(any())).thenAnswer((_) async => true);
      final datasource = UserDatasource(usersBox: mockBox, postsBox: mockPost);
      //act
      final result = await datasource.setUsers(users);
      //assert
      expect(result, equals(users));
    });
  });

  group('Should Test get All users', () {
    test('Should test get all users in user datasource succesfull', () async {
      when(() => mockBox.values).thenReturn(users);
      final datasource = UserDatasource(usersBox: mockBox, postsBox: mockPost);
      //act
      final result = await datasource.getUsers();
      //assert
      expect(result, equals(users));
    });
  });
}
