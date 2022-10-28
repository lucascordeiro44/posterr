import 'dart:js_util';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/post/domain/usecases/create_repost.usecase.dart';

import '../../../../mocks.dart';
import 'get_post.usecase_test.dart';

void main() {
  test('Should test create a repost from some post', () async {
    //arrenge
    when(() => postRepository.createRepost(any()))
        .thenAnswer((_) async => const Right(true));

    //act
    final result = await CreateRepostUsecase(postRepository).call(post);

    //assert
    // verify(() => postRepository.createRepost(any()));
    expect(result, const Right(true));
  });
}
