import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

import '../../../../mocks.dart';

class MockHive extends Mock implements Box<User> {}

final mockBox = MockHive();

void main() {
  test('Should test GetUser in user datasource', () async {
    when(() => mockBox.get(any())).thenReturn(user);
    final datasource = UserDatasource(box: mockBox);
    //act
    final result = await datasource.getUser(user.username);
    //assert
    expect(result, equals(user));
  });
}
