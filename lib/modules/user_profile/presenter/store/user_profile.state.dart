import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class UserProfileState {}

class SuccessUserProfileState implements UserProfileState {
  final User user;
  SuccessUserProfileState(this.user);
}

class InitialUserProfileState extends UserProfileState {}

class LoadingUserProfileState extends UserProfileState {}

class ErrorUseProfileState extends UserProfileState {
  final String message;
  ErrorUseProfileState(this.message);
}
