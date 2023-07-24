class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() {
    return 'NetworkException{message: $message, statusCode: $statusCode}';
  }
}

class AuthException extends NetworkException {
  AuthException({message, statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  String toString() {
    return 'AuthException{}';
  }
}
