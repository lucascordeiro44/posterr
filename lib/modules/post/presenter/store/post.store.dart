import 'package:flutter/cupertino.dart';
import 'package:posterr/modules/post/domain/usecases/create_post.usecase.dart';
import 'package:posterr/modules/post/domain/usecases/get_posts.usecase.dart';
import 'package:posterr/modules/post/presenter/states/post.state.dart';

class PostStore extends ValueNotifier<PostState> {
  final IGetPostsUsecase usecase;
  final ICreatePostUsecase createUsecase;
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  PostStore(this.usecase, this.createUsecase) : super(EmptyPostState([]));

  void emit(PostState newState) => value = newState;

  Future<void> fetchPosts() async {
    emit(LoadingPostState());
    final result = await usecase.call();
    final newState = result.fold((l) {
      return ErrorPostState(l.message);
    }, (r) {
      return SuccessPostState(r);
    });
    emit(newState);
  }

  Future<void> createPost(String title, String text) async {
    await createUsecase.call(title, text);
    await fetchPosts();
  }
}
