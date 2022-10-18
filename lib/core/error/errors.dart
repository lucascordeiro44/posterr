abstract class IException {
  final String message;
  StackTrace? stackTrace;
  IException({required this.message, this.stackTrace });
}

class GetUserException extends IException {
  GetUserException({required super.message});

}