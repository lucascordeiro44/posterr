import 'package:posterr/modules/post/domain/entities/post.dart';

abstract class PostState {}

class SuccessPostState implements PostState {
  final List<Post> posts;
  SuccessPostState(this.posts);
}

class EmptyPostState extends SuccessPostState {
  EmptyPostState(List<Post> posts) : super([]);
}

class LoadingPostState extends PostState {}

class ErrorPostState extends PostState {
  final String message;
  ErrorPostState(this.message);
}
