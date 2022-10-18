abstract class IException {
  final String message;
  StackTrace? stackTrace;
  IException({required this.message, this.stackTrace });
}

class UserException extends IException {
  UserException({required super.message});

}