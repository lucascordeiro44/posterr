import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';

import '../../../../mocks.dart';

final mockBox = MockHivePost();
void main() {
  test('Should test get post datasource', () async {
    //arrange
    when(() => mockBox.getAt(any())).thenReturn(post);
    //act
    final result = await PostDatasource(mockBox).getPost(any());
    //assert
    expect(result, post);
  });
}
