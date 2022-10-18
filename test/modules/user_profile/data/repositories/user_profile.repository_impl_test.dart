import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/user_profile/data/repositories/user_profile.repository_impl.dart';

import '../../../../mocks.dart';

final mockUserDatasource = MockUserDatasource();

void main() {
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
}
