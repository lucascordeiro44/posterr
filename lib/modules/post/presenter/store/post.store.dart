import 'package:flutter/cupertino.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/usecases/create_post.usecase.dart';
import 'package:posterr/modules/post/domain/usecases/create_quote_post.usecase.dart';
import 'package:posterr/modules/post/domain/usecases/create_repost.usecase.dart';
import 'package:posterr/modules/post/domain/usecases/get_home_content.usecase.dart';
import 'package:posterr/modules/post/presenter/states/post.state.dart';

class PostStore extends ValueNotifier<HomeContentState> {
  final IGetHomeContentUsecase getHomeContentUsecase;
  final ICreatePostUsecase createUsecase;
  final ICreateRepostUsecase createRepostUsecase;
  final ICreateQuotePostUsecase createQuotePostUsecase;
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  PostStore(this.getHomeContentUsecase, this.createUsecase,
      this.createRepostUsecase, this.createQuotePostUsecase)
      : super(InitialHomeContentState([]));

  void emit(HomeContentState newState) => value = newState;

  Future<void> fetchHomeContent() async {
    emit(LoadingHomeContentState());
    final result = await getHomeContentUsecase.call();
    final newState = result.fold((l) {
      return ErrorHomeContentState(l.message);
    }, (r) {
      return SuccessHomeContentState(r);
    });
    emit(newState);
  }

  Future<void> createPost(String title, String text) async {
    await createUsecase.call(title, text);
    await fetchHomeContent();
  }

  Future<void> createRepost(Post post) async {
    await createRepostUsecase.call(post);
    await fetchHomeContent();
  }

  Future<void> createQuotePost(Post post, String comment) async {
    await createQuotePostUsecase.call(post, comment);
    await fetchHomeContent();
  }
}
