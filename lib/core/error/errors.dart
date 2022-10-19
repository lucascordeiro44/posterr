abstract class IException {
  final String message;
  StackTrace? stackTrace;
  IException({required this.message, this.stackTrace});
}

class UserException extends IException {
  UserException({required super.message, super.stackTrace});
}

class CacheException extends IException {
  CacheException({required super.message, super.stackTrace});
}
