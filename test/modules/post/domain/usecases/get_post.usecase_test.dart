import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/post/domain/usecases/get_posts.usecase.dart';

import '../../../../mocks.dart';

final postRepository = MockPostsRepository();

void main() {
  test('Should test getPost usecese and return a post', () async {
    when(() => postRepository.getPost(any()))
        .thenAnswer((_) async => Right(post));

    //act
    final result = await GetPostsUsecase(postRepository).call();

    //assert
    expect(result, equals(Right(post)));
  });
}
