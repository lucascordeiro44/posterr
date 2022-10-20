abstract class IException {
  final String message;
  StackTrace? stackTrace;
  IException({required this.message, this.stackTrace});
}

class UserException extends IException {
  UserException({required super.message, super.stackTrace});
}

abstract class Failure {
  final String message;
  StackTrace? stackTrace;
  Failure({required this.message, this.stackTrace});
}

class SetUserException extends Failure {
  SetUserException({required super.message, super.stackTrace});
}

class GetUserException extends Failure {
  GetUserException({required super.message, super.stackTrace});
}

class PostFailure extends Failure {
  PostFailure({required super.message});
}

class PostException extends IException {
  PostException({required super.message});
}
