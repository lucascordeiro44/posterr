import 'package:posterr/core/models/content_item.dart';

abstract class UserProfileState {}

class SuccessUserProfileState implements UserProfileState {
  final List<ContentItem> contents;
  SuccessUserProfileState(this.contents);
}

class InitialUserProfileState extends SuccessUserProfileState {
  InitialUserProfileState(super.contents);
}

class LoadingUserProfileState extends UserProfileState {}

class ErrorUserProfileState extends UserProfileState {
  final String message;
  ErrorUserProfileState(this.message);
}

