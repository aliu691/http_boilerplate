class AppExceptions implements Exception {
  final String message;
  final String url;
  AppExceptions({
    required this.message,
    required this.url,
  });
}

//400 error(bad request)
class BadRequestException extends AppExceptions {
  BadRequestException({required super.message, required super.url});
}

//401 and 403 error(unauthorized and failed authentication)
class UnauthorizedException extends AppExceptions {
  UnauthorizedException({required super.message, required super.url});
}

//Timeout
class ApiTimeoutException extends AppExceptions {
  ApiTimeoutException({required super.message, required super.url});
}

//Generic fetch data error
class FetchDataException extends AppExceptions {
  FetchDataException({required super.message, required super.url});
}
