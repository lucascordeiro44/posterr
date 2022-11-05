import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class ChooseUserState {}

class SuccessChooseUserState implements ChooseUserState {
  final List<User> users;
  SuccessChooseUserState(this.users);
}

class EmptyChooseUserState extends SuccessChooseUserState {
  EmptyChooseUserState(List<Post> posts) : super([]);
}

class LoadingChooseUserState extends ChooseUserState {}

class ErrorChooseUserState extends ChooseUserState {
  final String message;
  ErrorChooseUserState(this.message);
}
