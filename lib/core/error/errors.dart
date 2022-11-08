abstract class IException {
  final String message;
  StackTrace? stackTrace;
  IException({required this.message, this.stackTrace});
}

class UserException extends IException {
  UserException({required super.message, super.stackTrace});
}

abstract class Failure implements Exception {
  final String message;
  StackTrace? stackTrace;
  Failure({required this.message, this.stackTrace});
}

class SetUserException extends Failure {
  SetUserException({required super.message, super.stackTrace});
}

class GetPostsException extends Failure {
  GetPostsException({required super.message, super.stackTrace});
}

class GetUserException extends Failure {
  GetUserException({required super.message, super.stackTrace});
}

class NullPostException implements Exception {}

class PostFailure extends Failure {
  PostFailure({required super.message});
}

class RepostFailure extends Failure {
  RepostFailure({required super.message});
}

class HomeContentFailure extends Failure {
  HomeContentFailure({required super.message});
}

class NullPostFailure extends Failure {
  NullPostFailure({required super.message});
}

class ErrorGetLoggedUser extends Failure {
  ErrorGetLoggedUser({required super.message});
}

class PostException extends IException {
  PostException({required super.message});
}

class RepostException extends IException {
  RepostException({required super.message});
}

class GetHomeContentException extends IException {
  GetHomeContentException({required super.message});
}
