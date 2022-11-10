import 'package:posterr/core/models/content_item.dart';

abstract class HomeContentState {}

class SuccessHomeContentState implements HomeContentState {
  final List<ContentItem> contents;
  SuccessHomeContentState(this.contents);
}

class InitialHomeContentState extends SuccessHomeContentState {
  InitialHomeContentState(super.contents);
}

class LoadingHomeContentState extends HomeContentState {}

class ErrorHomeContentState extends HomeContentState {
  final String message;
  ErrorHomeContentState(this.message);
}
