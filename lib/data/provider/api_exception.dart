class ApiException implements Exception {
  final String code;
  final String message;
  final String? details;

  ApiException({required this.code, required this.message, this.details});

  @override
  String toString() {
    return "[$code]: $message \n $details";
  }
}

class FetchDataException extends ApiException {
  FetchDataException(String? details)
      : super(
          code: "fetch-data",
          message: "Error During Communication",
          details: details,
        );
}

class BadRequestException extends ApiException {
  BadRequestException(String? details)
      : super(
          code: "invalid-request",
          message: "Invalid Request",
          details: details,
        );
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String? details)
      : super(
          code: "unauthorized",
          message: "Unauthorized",
          details: details,
        );
}

class UnprocessableEntityException extends ApiException {
  UnprocessableEntityException(String? details)
      : super(
          code: "unprocessable-entity",
          message: "Unprocessable Entity",
          details: details,
        );
}

class InvalidInputException extends ApiException {
  InvalidInputException(String? details)
      : super(
          code: "invalid-input",
          message: "Invalid Input",
          details: details,
        );
}

class AuthenticationException extends ApiException {
  AuthenticationException(String? details)
      : super(
          code: "authentication-failed",
          message: "Authentication Failed",
          details: details,
        );
}

class TimeOutException extends ApiException {
  TimeOutException(String? details)
      : super(
          code: "request-timeout",
          message: "Request TimeOut",
          details: details,
        );
}
