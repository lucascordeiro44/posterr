import 'package:flutter/material.dart';
import 'package:posterr/core/shared/stores/auth_store.dart';
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
  final GlobalKey refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final ScrollController listController = ScrollController();
  final formKey = GlobalKey<FormState>();
  final AuthStore authStore;
  PostStore(this.getHomeContentUsecase, this.createUsecase,
      this.createRepostUsecase, this.createQuotePostUsecase, this.authStore)
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

  Future<bool> createPost(String title, String text) async {
    if (authStore.getLoggedUser.canPublish()) {
      await createUsecase.call(title, text);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createRepost(Post post) async {
    if (authStore.getLoggedUser.canPublish()) {
      await createRepostUsecase.call(post);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createQuotePost(Post post, String comment) async {
    if (authStore.getLoggedUser.canPublish()) {
      await createQuotePostUsecase.call(post, comment);
      await fetchHomeContent();
      return true;
    } else {
      return false;
    }
  }

  void scrollToTop() {
    listController.animateTo(
      listController.position.minScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
