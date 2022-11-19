import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class AuthStoreState {}

class SuccessAuthStoreState implements AuthStoreState {
  final User user;
  SuccessAuthStoreState(this.user);
}

class InitiaAuthStoreState extends AuthStoreState {}

class LoadingAuthStoreState extends AuthStoreState {}

class ErrorAuthStoreState extends AuthStoreState {
  final String message;
  ErrorAuthStoreState(this.message);
}
