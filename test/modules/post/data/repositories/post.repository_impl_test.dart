import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/post/data/repositories/post.repository_impl.dart';
import 'package:posterr/modules/user_profile/presenter/store/user_profile.store.dart';

import '../../../../mocks.dart';

final postDatasource = MockPostDatasource();
final UserProfileStore useStore = Modular.get();

void main() {
  test('Should test get repost', () async {
    //arrange
    when(() => postDatasource.getPost(any())).thenAnswer((_) async => post);

    //act
    final result =
        await PostRepositoryImpl(postDatasource, useStore).getPost(any());

    //assert
    expect(result, Right(post));
  });

  test('Should test if repository create one repost', () async {
    //arrange
    when((() => postDatasource.createRepost(any())))
        .thenAnswer((_) async => true);

    //act
    final result =
        await PostRepositoryImpl(postDatasource, useStore).createRepost(post);

    //assert
    expect(result, const Right(true));
  });
}
